# how many flights are cancelled in December 
SELECT COUNT(CANCELLED) AS CountofCancelled
FROM `data-mgnt-project.flights_data.flights_dec`
WHERE CANCELLED=1;

# the most popular cancell reason
SELECT CANCELLATION_REASON, COUNT(CANCELLATION_REASON) AS Counts
FROM `data-mgnt-project.flights_data.flights_dec`
WHERE CANCELLED=1
GROUP BY CANCELLATION_REASON
ORDER BY COUNT(CANCELLATION_REASON)
LIMIT 1;

# which day of week have highest cancelled in December 
SELECT DAY_OF_WEEK, COUNT(DAY_OF_WEEK) AS CancelledCount
FROM `data-mgnt-project.flights_data.flights_dec`
WHERE CANCELLED=1
GROUP BY DAY_OF_WEEK
ORDER BY COUNT(DAY_OF_WEEK) DESC;

# delay airline count
SELECT AIRLINE, COUNT(AIRLINE) AS Counts 
FROM `data-mgnt-project.flights_data.flights_dec`
WHERE ARRIVAL_DELAY > 0 OR DEPARTURE_DELAY > 0
GROUP BY AIRLINE 
ORDER BY Counts DESC;

# delay flight count
SELECT ORIGIN_AIRPORT, DESTINATION_AIRPORT, COUNT(ORIGIN_AIRPORT) AS Counts 
FROM `data-mgnt-project.flights_data.flights_dec`
WHERE ARRIVAL_DELAY > 0 OR DEPARTURE_DELAY > 0
GROUP BY ORIGIN_AIRPORT, DESTINATION_AIRPORT 
ORDER BY Counts DESC;

# ranking count of flight state 
SELECT STATE, COUNT(STATE) AS StateCount
FROM `data-mgnt-project.flights_data.flights_dec` JOIN `data-mgnt-project.flights_data.airports`
ON `data-mgnt-project.flights_data.flights_dec`.ORIGIN_AIRPORT=`data-mgnt-project.flights_data.airports`.IATA_CODE
GROUP BY STATE
ORDER BY COUNT(STATE) DESC;

# which day have most flight, maybe near holiday?
SELECT DAY, COUNT(FLIGHT_NUMBER) AS FlightCount
FROM `data-mgnt-project.flights_data.flights_dec`
GROUP BY DAY
ORDER BY COUNT(FLIGHT_NUMBER) DESC;


# which airline have delay time higher than average delay time 
SELECT string_field_1 AS Airline, AVG(ARRIVAL_DELAY) AS AvgDelayTime
FROM `data-mgnt-project.flights_data.flights_dec` JOIN `data-mgnt-project.flights_data.airlines`
ON `data-mgnt-project.flights_data.flights_dec`.AIRLINE=`data-mgnt-project.flights_data.airlines`.string_field_0	
WHERE ARRIVAL_DELAY > (SELECT AVG(ARRIVAL_DELAY)
FROM `data-mgnt-project.flights_data.flights_dec`)
GROUP BY AIRLINE
ORDER BY AVG(ARRIVAL_DELAY) DESC;
