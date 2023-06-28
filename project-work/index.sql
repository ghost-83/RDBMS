-- Для увеличения скорости поиска
CREATE INDEX IF NOT EXISTS informing_data_status_idx ON sms_center.informing_data (status);
CREATE INDEX IF NOT EXISTS informing_data_send_date_idx ON sms_center.informing_data (send_date);
CREATE INDEX IF NOT EXISTS informing_data_send_date_idx ON sms_center.informing_data (region, header_id, update_date);