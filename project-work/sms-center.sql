CREATE SCHEMA IF NOT EXISTS sms_center;

CREATE TABLE IF NOT EXISTS sms_center.sms_center_status
(
    id            BIGSERIAL PRIMARY KEY,
    number_status INT          NOT NULL,
    text_status   VARCHAR(255) NOT NULL,
    type          VARCHAR(50)  NOT NULL,
    critical      VARCHAR(50)  NOT NULL
);

CREATE TABLE IF NOT EXISTS sms_center.informing_data
(
    header_id         BIGINT       NOT NULL,
    insurance_id      BIGINT       NOT NULL,
    project           VARCHAR(50)  NOT NULL,
    region            INT          NOT NULL,
    informing_channel VARCHAR(100) NOT NULL,
    status            VARCHAR(10)  NOT NULL,
    data_json         jsonb        NOT NULL,
    list_uuid         VARCHAR(50),
    send_date         TIMESTAMP WITH TIME ZONE,
    update_date       TIMESTAMP WITH TIME ZONE,

    PRIMARY KEY (insurance_id, project, informing_channel)
);

CREATE TABLE IF NOT EXISTS sms_center.informing_message
(
    insurance_id      BIGINT NOT NULL,
    project           VARCHAR(50) NOT NULL,
    informing_channel VARCHAR(100) NOT NULL,
    status            INT NOT NULL,
    last_timestamp    BIGINT,
    last_date         TIMESTAMP WITH TIME ZONE,
    send_timestamp    BIGINT,
    send_date         TIMESTAMP WITH TIME ZONE,
    cost              VARCHAR(10),
    status_name       VARCHAR(100),
    mccmnc            VARCHAR(24),
    country           VARCHAR(24),
    operator          VARCHAR(50),
    region            VARCHAR(100),
    type              INT,
    err               INT,

    PRIMARY KEY (insurance_id, project, informing_channel)
);

CREATE TYPE sms_center.sms_center_settings_voice AS ENUM ('m', 'm2', 'w', 'w2', 'w3');

CREATE TABLE IF NOT EXISTS sms_center.sms_center_settings
(
    id                 BIGSERIAL PRIMARY KEY,
    login              VARCHAR(100)                         NOT NULL,
    password           VARCHAR(100)                         NOT NULL,
    region             INT                                  NOT NULL,
    project            VARCHAR(50)                          NOT NULL,
    phone_sender       VARCHAR(50)                          NOT NULL,
    text_sender        VARCHAR(50)                          NOT NULL,
    email_sender       VARCHAR(50)                          NOT NULL,
    waiting_time       INT                                  NOT NULL,
    repeat_interval    INT                                  NOT NULL,
    number_of_attempts INT                                  NOT NULL,
    voice              sms_center.sms_center_settings_voice NOT NULL
);

INSERT INTO sms_center.sms_center_status(number_status, text_status, type, critical)
VALUES (1, 'Ошибка в параметрах.', 'ERROR', 'FAIL'),
       (2, 'Неверный логин или пароль.', 'ERROR', 'FAIL'),
       (3, 'Недостаточно средств на счете Клиента.', 'ERROR', 'FAIL'),
       (4, 'IP-адрес временно заблокирован из-за частых ошибок в запросах.', 'ERROR', 'FAIL'),
       (5, 'Неверный формат даты.', 'ERROR', 'FAIL'),
       (6, 'Сообщение запрещено (по тексту или по имени отправителя).', 'ERROR', 'FAIL'),
       (7, 'Неверный формат номера телефона.', 'ERROR', 'FAIL'),
       (8, 'Сообщение на указанный номер не может быть доставлено.', 'ERROR', 'FAIL'),
       (9,
        'Отправка более одного одинакового запроса на передачу SMS-сообщения либо более пяти одинаковых запросов на получение стоимости сообщения в течение минуты.',
        'ERROR', 'FAIL'),
       (-3, 'Сообщение не найдено.', 'STATUS', 'PENDING'),
       (-2,
        'Возникает у сообщений из рассылки, которые не успели уйти оператору до момента временной остановки данной рассылки.',
        'STATUS', 'PENDING'),
       (-1, 'Ожидает отправки.', 'STATUS', 'PENDING'),
       (0, 'Передано оператору.', 'STATUS', 'PENDING'),
       (1, 'Доставлено.', 'STATUS', 'OK'),
       (2, 'Прочитано.', 'STATUS', 'OK'),
       (3, 'Просрочено.', 'STATUS', 'FAIL'),
       (4, 'Нажата ссылка.', 'STATUS', 'OK'),
       (20, 'Невозможно доставить.', 'STATUS', 'FAIL'),
       (22, 'Неверный номер.', 'STATUS', 'FAIL'),
       (23, 'Запрещено.', 'STATUS', 'FAIL'),
       (24, 'Недостаточно средств.', 'STATUS', 'FAIL'),
       (25, 'Недоступный номер.', 'STATUS', 'FAIL'),
       (0, 'Нет ошибки.', 'ERR', 'OK'),
       (1, 'Абонент не существует.', 'ERR', 'FAIL'),
       (6, 'Абонент не в сети.', 'ERR', 'PENDING'),
       (11, 'Нет услуги SMS.', 'ERR', 'FAIL'),
       (12, 'Ошибка в телефоне абонента.', 'ERR', 'FAIL'),
       (13, 'Ошибка в телефоне абонента.', 'ERR', 'FAIL'),
       (21, 'Нет поддержки сервиса.', 'ERR', 'FAIL'),
       (200, 'Виртуальная отправка.', 'ERR', 'OK'),
       (219, 'Замена sim-карты.', 'ERR', 'FAIL'),
       (237, 'Абонент не отвечает.', 'ERR', 'FAIL'),
       (239, 'Запрещенный ip-адрес.', 'ERR', 'FAIL'),
       (240, 'Абонент занят.', 'ERR', 'FAIL'),
       (241, 'Ошибка конвертации.', 'ERR', 'FAIL'),
       (242, 'Зафиксирован автоответчик.', 'ERR', 'FAIL'),
       (243, 'Не заключен договор.', 'ERR', 'FAIL'),
       (245, 'Статус не получен.', 'ERR', 'FAIL'),
       (246, 'Ограничение по времени.', 'ERR', 'FAIL'),
       (247, 'Превышен лимит сообщений.', 'ERR', 'FAIL'),
       (248, 'Нет маршрута.', 'ERR', 'FAIL'),
       (249, 'Неверный формат номера.', 'ERR', 'FAIL'),
       (250, 'Номер запрещен настройками.', 'ERR', 'FAIL'),
       (251, 'Превышен лимит на один номер.', 'ERR', 'FAIL'),
       (252, 'Номер запрещен.', 'ERR', 'FAIL'),
       (253, 'Запрещено спам-фильтром.', 'ERR', 'FAIL'),
       (254, 'Незарегистрированный sender id.', 'ERR', 'FAIL'),
       (255, 'Отклонено оператором.', 'ERR', 'FAIL');

INSERT INTO sms_center.sms_center_settings(login, password, region, project, phone_sender, text_sender,
                                           email_sender,
                                           waiting_time,
                                           repeat_interval, number_of_attempts, voice)
VALUES ('test_42', 'test_42', 42, 'test-informing-integration', '+78005550000', 'test',
        'test@test.ru', 30, 600, 2, 'w3'),
       ('test_71', 'test_71', 71, 'test-informing-integration', '+78005550000', 'test', 'test@test.ru', 30,
        600, 2, 'w3'),
       ('test_53', 'test_53', 53, 'test-informing-integration', '+78005550000', 'test', 'test@test.ru',
        30, 600, 2, 'w3'),
       ('test_32', 'test_32', 32, 'test-informing-integration', '+78005550000', 'test', 'test@test.ru',
        30, 600, 2, 'w3'),
       ('test_55', 'testk_55', 55, 'test-informing-integration', '+78005550000', 'test', 'test@test.ru', 30,
        600, 2, 'w3'),
       ('test_69', 'test_69', 69, 'test-informing-integration', '+78005550000', 'test', 'test@test.ru',
        30, 600, 2, 'w3'),
       ('test_74', 'test_74', 74, 'test-informing-integration', '+78005550000', 'test',
        'test@test.ru', 30, 600, 2, 'w3'),
       ('test_61', 'test_61', 61, 'test-informing-integration', '+78005550000', 'test', 'test@test.ru',
        30, 600, 2, 'w3'),
       ('test_23', 'test_23', 23, 'test-informing-integration', '+78005550000', 'test',
        'test@test.ru', 30, 600, 2, 'w3'),
       ('test_72', 'test_72', 72, 'test-informing-integration', '+78005550000', 'test', 'test@test.ru',
        30, 600, 2, 'w3'),
       ('test_02', 'test_02', 02, 'test-informing-integration', '+78005550000', 'test', 'test@test.ru', 30,
        600, 2, 'w3'),
       ('test_86', 'test_86', 86, 'test-informing-integration', '+78005550000', 'test', 'test@test.ru',
        30, 600, 2, 'w3'),
       ('test_51', 'test_51', 51, 'test-informing-integration', '+78005550000', 'test', 'test@test.ru',
        30, 600, 2, 'w3');

COMMENT ON TABLE sms_center.sms_center_status IS 'Таблица данных для информирования';
COMMENT ON COLUMN sms_center.sms_center_status.id IS 'ID';
COMMENT ON COLUMN sms_center.sms_center_status.number_status IS 'Статус получаемый от Смс-Центра';
COMMENT ON COLUMN sms_center.sms_center_status.text_status IS 'Описание статуса получаемого от Смс-Центра';
COMMENT ON COLUMN sms_center.sms_center_status.type IS 'Тип статуса получаемого от Смс-Центра';
COMMENT ON COLUMN sms_center.sms_center_status.critical IS 'Как расценивать данный статус основной системе';

COMMENT ON TABLE sms_center.informing_data IS 'Таблица хранения основных данных для информирования';
COMMENT ON COLUMN sms_center.informing_data.header_id IS 'ID списка информирования';
COMMENT ON COLUMN sms_center.informing_data.insurance_id IS 'ID клиента из списка информирования';
COMMENT ON COLUMN sms_center.informing_data.project IS 'Имя подразделения загрузившего список';
COMMENT ON COLUMN sms_center.informing_data.region IS 'Регион в котором зарегистрирован клиент';
COMMENT ON COLUMN sms_center.informing_data.informing_channel IS 'По какому каналу нужно проинформировать клиента';
COMMENT ON COLUMN sms_center.informing_data.status IS 'В каком статусе находится информирование';
COMMENT ON COLUMN sms_center.informing_data.data_json IS 'Данные которые хранят информацию о клиенте для информирования, а так же основные результаты информирования';
COMMENT ON COLUMN sms_center.informing_data.list_uuid IS 'ID сформированного списка отправленного на информирование, по данному ID и номеру телефона клиента будут получаться статусы';
COMMENT ON COLUMN sms_center.informing_data.send_date IS 'Дата и время отправки сообщения';
COMMENT ON COLUMN sms_center.informing_data.list_uuid IS 'Дата и время последнего обновления информации по сообщению';

-- Данная таблица, сохраняет все данные которые присылает смс-центр и нужна только в случае возникновения технических проблем.
COMMENT ON TABLE sms_center.informing_message IS 'Таблица хранения данных получаемых от Смс-Центра по итогам информирования.';

COMMENT ON TABLE sms_center.sms_center_settings IS 'Таблица хранения данных необходимых для работы с API Смс-Центра.';
COMMENT ON COLUMN sms_center.sms_center_settings.id IS 'ID';
COMMENT ON COLUMN sms_center.sms_center_settings.login IS 'Логин для подключения к API Смс-Центра';
COMMENT ON COLUMN sms_center.sms_center_settings.password IS 'Пароль для подключения к API Смс-Центра';
COMMENT ON COLUMN sms_center.sms_center_settings.region IS 'Регион для определения нужных технических данных';
COMMENT ON COLUMN sms_center.sms_center_settings.project IS 'Название подразделения для определения нужных технических данных';
COMMENT ON COLUMN sms_center.sms_center_settings.phone_sender IS 'Номер телефона который будет высвечиваться у клиента в момент информирования';
COMMENT ON COLUMN sms_center.sms_center_settings.email_sender IS 'Почтовый ящик который будет высвечиваться у клиента в момент информирования';
COMMENT ON COLUMN sms_center.sms_center_settings.waiting_time IS 'Время продолжения ответа клиента в случае звонка(сек.)';
COMMENT ON COLUMN sms_center.sms_center_settings.repeat_interval IS 'Время совершение повторного звонка в случае неудачи предыдущего(сек.)';
COMMENT ON COLUMN sms_center.sms_center_settings.number_of_attempts IS 'Количество повторных звонков';
COMMENT ON COLUMN sms_center.sms_center_settings.voice IS 'Голос который будет произносить сообщение';