# Question 3

_How many taxi trips were there on January 15? Consider only trips that started on January 15._

**Solution:**

```
SELECT
	CAST(tpep_pickup_datetime AS date) AS "day",
	COUNT(1)
FROM
	yellow_taxi_data
WHERE
	CAST(tpep_pickup_datetime AS date) = '2021-01-15'
GROUP BY
	"day"
```

# Question 4

_Find the largest tip for each day. On which day it was the largest tip in January? Use the pick up time for your calculations. (note: it's not a typo, it's "tip", not "trip")_

**Solution:**

```
SELECT
	CAST(tpep_pickup_datetime AS date) AS "day",
	MAX(tip_amount) AS "max_tip"
FROM
	yellow_taxi_data
GROUP BY
	"day"
ORDER BY
	"max_tip" DESC
```

# Question 5

_What was the most popular destination for passengers picked up in central park on January 14? Use the pick up time for your calculations. Enter the zone name (not id). If the zone name is unknown (missing), write "Unknown"_

**Solution:**

```
SELECT
	zdo."Zone" AS "do_loc_zone",
	COUNT(1)
FROM
	yellow_taxi_data t
	LEFT JOIN zones zpu
		ON t."PULocationID" = zpu."LocationID"
	LEFT JOIN zones zdo
		ON t."DOLocationID" = zdo."LocationID"
WHERE
	CAST(tpep_pickup_datetime AS date) = '2021-01-14'
	AND zpu."Zone" = 'Central Park'
GROUP BY
	"do_loc_zone"
ORDER BY
	"count" DESC
```

# Question 6

_What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)? Enter two zone names separated by a slash._

**Solution:**

```
SELECT
	CONCAT(COALESCE(zpu."Zone", 'Unknown'), ' / ', COALESCE(zdo."Zone", 'Unknown')) AS "pu_do_zones",
	AVG(total_amount)
FROM
	yellow_taxi_data t
	LEFT JOIN zones zpu
		ON t."PULocationID" = zpu."LocationID"
	LEFT JOIN zones zdo
		ON t."DOLocationID" = zdo."LocationID"
GROUP BY
	"pu_do_zones"
ORDER BY
	AVG DESC
```
