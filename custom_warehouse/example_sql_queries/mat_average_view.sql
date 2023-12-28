-- This SQL Query will create a view called 'mat_average_view' for MAT average attendance in 'example_database'.
-- This assumes you are a MAT using ARBOR_BI_CONNECTOR_PRODUCTION. 

create or replace view example_database.example_schema.mat_average_view(
	AVG_IS_PRESENT_ALL_TIME,
	AVG_IS_AUTHORIZED_ABSENT_ALL_TIME,
	AVG_IS_UNAUTHORIZED_ABSENT_ALL_TIME,
	AVG_IS_POSSIBLE_ATTENDANCE_ALL_TIME
  
) as (

select
    AVG(is_present),
    AVG(is_authorized_absent),
    AVG(is_unauthorized_absent),
    AVG(is_possible_attendance)

from ARBOR_BI_CONNECTOR_PRODUCTION.ARBOR_MIS_ENGLAND_MODELLED.ROLL_CALL_ATTENDANCE
