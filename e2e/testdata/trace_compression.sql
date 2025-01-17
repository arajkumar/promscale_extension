\set ECHO all
\set ON_ERROR_STOP 1

CREATE EXTENSION promscale;

-- We don't want retention to mess with the test data
SELECT ps_trace.set_trace_retention_period('100 years'::INTERVAL);

INSERT INTO _ps_trace.span(trace_id,span_id,parent_span_id,operation_id,start_time,end_time,duration_ms,trace_state,span_tags,dropped_tags_count,event_time,dropped_events_count,dropped_link_count,status_code,status_message,instrumentation_lib_id,resource_tags,resource_dropped_tags_count,resource_schema_url_id)
    VALUES
        (E'18dd078e-8c69-e10a-d2fe-9e9f47de7728',-2771219554170079234,NULL,19,E'2022-04-26 11:44:55.185139+00',E'2022-04-26 11:44:55.38517+00',200.031,NULL,E'{"1003": 247}',0,E'["2022-04-26 11:44:55.185659+00","2022-04-26 11:44:55.385148+00")',0,0,E'error',E'Exception: FAILED to fetch a lower char',5,E'{"1": 114, "5": 94, "6": 93, "7": 95}',0,NULL),
        (E'15a8be0f-bb79-c052-223e-48608580efce',2625299614982951051,NULL,19,E'2022-04-26 11:44:55.185962+00',E'2022-04-26 11:44:55.288812+00',102.85,NULL,E'{"1003": 242}',0,E'["2022-04-26 11:44:55.185999+00","2022-04-26 11:44:55.288781+00")',0,0,E'error',E'Exception: FAILED to fetch a lower char',5,E'{"1": 114, "5": 94, "6": 93, "7": 95}',0,NULL);

SELECT hypertable_schema, hypertable_name,  chunk_schema, chunk_name, is_compressed FROM timescaledb_information.chunks order by range_end desc;
CALL _ps_trace.execute_tracing_compression_job(0, jsonb '{"log_verbose":false,"hypertable_name":"span"}'); --noop

SELECT hypertable_schema, hypertable_name,  chunk_schema, chunk_name, is_compressed FROM timescaledb_information.chunks order by range_end desc;

INSERT INTO _ps_trace.span(trace_id,span_id,parent_span_id,operation_id,start_time,end_time,duration_ms,trace_state,span_tags,dropped_tags_count,event_time,dropped_events_count,dropped_link_count,status_code,status_message,instrumentation_lib_id,resource_tags,resource_dropped_tags_count,resource_schema_url_id)
    VALUES
        (E'28dd078e-8c69-e10a-d2fe-9e9f47de7728',-2771219554170079234,NULL,19,E'2022-04-26 12:44:55.185139+00',E'2022-04-26 11:44:55.38517+00',200.031,NULL,E'{"1003": 247}',0,E'["2022-04-26 11:44:55.185659+00","2022-04-26 11:44:55.385148+00")',0,0,E'error',E'Exception: FAILED to fetch a lower char',5,E'{"1": 114, "5": 94, "6": 93, "7": 95}',0,NULL),
        (E'25a8be0f-bb79-c052-223e-48608580efce',2625299614982951051,NULL,19,E'2022-04-26 12:44:55.185962+00',E'2022-04-26 11:44:55.288812+00',102.85,NULL,E'{"1003": 242}',0,E'["2022-04-26 11:44:55.185999+00","2022-04-26 11:44:55.288781+00")',0,0,E'error',E'Exception: FAILED to fetch a lower char',5,E'{"1": 114, "5": 94, "6": 93, "7": 95}',0,NULL);

CALL _ps_trace.execute_tracing_compression_job(0, jsonb '{"log_verbose":false,"hypertable_name":"span"}'); --compress one
SELECT hypertable_schema, hypertable_name,  chunk_schema, chunk_name, is_compressed FROM timescaledb_information.chunks order by range_end desc;
CALL _ps_trace.execute_tracing_compression_job(0, jsonb '{"log_verbose":false,"hypertable_name":"span"}'); --noop
SELECT hypertable_schema, hypertable_name,  chunk_schema, chunk_name, is_compressed FROM timescaledb_information.chunks order by range_end desc;


INSERT INTO _ps_trace.span(trace_id,span_id,parent_span_id,operation_id,start_time,end_time,duration_ms,trace_state,span_tags,dropped_tags_count,event_time,dropped_events_count,dropped_link_count,status_code,status_message,instrumentation_lib_id,resource_tags,resource_dropped_tags_count,resource_schema_url_id)
    VALUES
        (E'38dd078e-8c69-e10a-d2fe-9e9f47de7728',-2771219554170079234,NULL,19,E'2022-04-26 13:44:55.185139+00',E'2022-04-26 11:44:55.38517+00',200.031,NULL,E'{"1003": 247}',0,E'["2022-04-26 11:44:55.185659+00","2022-04-26 11:44:55.385148+00")',0,0,E'error',E'Exception: FAILED to fetch a lower char',5,E'{"1": 114, "5": 94, "6": 93, "7": 95}',0,NULL),
        (E'35a8be0f-bb79-c052-223e-48608580efce',2625299614982951051,NULL,19,E'2022-04-26 13:44:55.185962+00',E'2022-04-26 11:44:55.288812+00',102.85,NULL,E'{"1003": 242}',0,E'["2022-04-26 11:44:55.185999+00","2022-04-26 11:44:55.288781+00")',0,0,E'error',E'Exception: FAILED to fetch a lower char',5,E'{"1": 114, "5": 94, "6": 93, "7": 95}',0,NULL);

SELECT hypertable_schema, hypertable_name,  chunk_schema, chunk_name, is_compressed FROM timescaledb_information.chunks order by range_end desc;
CALL _ps_trace.execute_tracing_compression_job(0, jsonb '{"log_verbose":false,"hypertable_name":"span"}'); --compress another one
SELECT hypertable_schema, hypertable_name,  chunk_schema, chunk_name, is_compressed FROM timescaledb_information.chunks order by range_end desc;
CALL _ps_trace.execute_tracing_compression_job(0, jsonb '{"log_verbose":false,"hypertable_name":"span"}'); --noop
SELECT hypertable_schema, hypertable_name,  chunk_schema, chunk_name, is_compressed FROM timescaledb_information.chunks order by range_end desc;