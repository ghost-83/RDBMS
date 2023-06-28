-- Получение данных для отправки в Смс-Центр. Блокировка требуется для возможности горизонтального масштабирования.

WITH data AS (SELECT *
              FROM sms_center.informing_data
              WHERE header_id = :headerId
                AND informing_channel = :informingChannel
                AND project = :project
                AND status = 'SEND'
              LIMIT :limit FOR UPDATE SKIP LOCKED)
UPDATE sms_center.informing_data AS u_data
SET status      = 'PENDING',
    list_uuid   = :uuidList,
    send_date   = :sendDate,
    update_date = :updateDate
FROM data
WHERE u_data.project = data.project
  AND u_data.insurance_id = data.insurance_id
  AND u_data.informing_channel = data.informing_channel
RETURNING data.*;

-- Сохранение данных из kafka. Здесь используется INSERT чтобы исключить дубли сообщений, которые могут возникнуть в
-- случае проблем с transaction в kafka или интеграционных сервисах. Так же ито не даст случайно отправить одно и то же сообщение дважды.

INSERT INTO sms_center.informing_data (header_id, insurance_id, project, region, informing_channel, status, data_json, update_date)
VALUES (:headerId, :insuranceId, :project, :region, :informingChannel, :status, cast(:dataJson as jsonb), :dateUpdate)
ON CONFLICT (insurance_id, project, informing_channel) DO NOTHING;

-- Обновление данных после отправки или получения статуса

UPDATE sms_center.informing_data
SET header_id = :headerId,
    insurance_id = :insuranceId,
    project = :project,
    region = :region,
    informing_channel = :informingChannel,
    status = :status,
    data_json = cast(:dataJson as jsonb),
    update_date = :dateUpdate
WHERE insurance_id = :insuranceId
AND project = :project
AND informing_channel = :informingChannel;

-- Запрос на получение данных для проверки статусов в Смс-Центре. Блокировка используется для горизонтального масштабирования.
-- После запроса данные в бд нужно обновить. Блокировка избавляет от конкурентности нескольких сервисов проверяющих статус.

SELECT *
FROM sms_center.informing_data
WHERE status = 'PENDING'
  AND region = :region
  AND project = :project
  AND informing_channel = :informingChannel
  AND header_id = :headerId
  AND update_date < :boundTime
ORDER BY update_date
LIMIT :limit
    FOR UPDATE SKIP LOCKED;

-- Запрос на удаление устаревших данных

DELETE
FROM sms_center.informing_data
WHERE send_date < :dateDelete;

-- Запрос для получения информации об активных данных, для дальнейшей выборки и формированию списков на отправку или проверку статусов

SELECT header_id, informing_channel, project, region
FROM sms_center.informing_data
WHERE status = :status
GROUP BY header_id, informing_channel, project, region;