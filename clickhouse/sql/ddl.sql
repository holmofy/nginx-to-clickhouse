create database nginx;

create table if not exists nginx.access_logs(
    remote_addr String,
    host String,
    remote_user String,
    access_time DateTime,
    method String,
    uri String,
    code Int32,
    bytes_size Int64,
    referer String,
    user_agent String
) ENGINE = MergeTree()
ORDER BY access_time
PARTITION BY toYYYYMM(access_time);

CREATE TABLE nginx.access_logs_buffer AS nginx.access_logs ENGINE = Buffer(
    nginx, access_logs, 16, 
    10, 100, 
    10000, 1000000, 
    10000000, 100000000
);