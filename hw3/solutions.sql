/* Question 1: What is count for fhv vehicles data for year 2019? */

SELECT
	COUNT(*)
FROM
	`trips_data_all.fhv_tripdata_external_table`

/* Question 2: How many distinct dispatching_base_num we have in fhv for 2019? */

SELECT
	COUNT(DISTINCT dispatching_base_num)
FROM
	`trips_data_all.fhv_tripdata_external_table`

/* Question 3: Best strategy to optimize if query always filter by dropoff_datetime and order by dispatching_base_num? */

CREATE TABLE
	`trips_data_all.fhv_tripdata_partitioned_clustered`
PARTITION BY
	DATE(dropoff_datetime)
CLUSTER BY
	dispatching_base_num AS
SELECT * FROM `trips_data_all.fhv_tripdata_external_table`

/* Question 4: What is the count, estimated and actual data processed for query which counts trip between 2019/01/01 and 2019/03/31 for dispatching_base_num B00987, B02060, B02279? */

SELECT
	COUNT(*)
FROM
	`trips_data_all.fhv_tripdata_partitioned_clustered`
WHERE
	DATE(dropoff_datetime) BETWEEN '2019-01-01' AND '2019-03-31'
    AND dispatching_base_num IN ('B00987', 'B02060', 'B02279')
