-- Данная схема и таблицы нужны для хранения оперативной информации по работе сервиса со списками

CREATE SCHEMA IF NOT EXISTS monitoring;

CREATE TABLE IF NOT EXISTS monitoring.input_header_monitoring
(
    header_id     BIGINT       NOT NULL,
    project_name  VARCHAR(255) NOT NULL,
    channels_data jsonb,

    PRIMARY KEY (header_id, project_name)
);

CREATE TABLE IF NOT EXISTS monitoring.output_header_monitoring
(
    header_id     BIGINT       NOT NULL,
    project_name  VARCHAR(255) NOT NULL,
    channels_data jsonb,

    PRIMARY KEY (header_id, project_name)
);