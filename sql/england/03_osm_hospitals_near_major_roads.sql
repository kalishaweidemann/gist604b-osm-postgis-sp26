-- Query 3: Hospitals near major roads
-- Purpose: Identify hospitals located within 1 km of major roads (motorway, trunk, primary).
-- Road classes are based on the OSM highway tagging scheme.

-- Check unique fclass values in pois table to find hospital value for WHERE clause
-- SELECT DISTINCT fclass FROM pois;

-- Check unique fclass values in roads table to understand range of values for WHERE clause
-- SELECT DISTINCT fclass FROM roads;

-- Spatial proximity (ST_DWithin) between hospitals and selected road classes
WITH major_roads AS (
    SELECT
        geom
    FROM
        roads
    WHERE
        fclass IN ('motorway', 'trunk', 'primary')
)

SELECT
    p.name AS hospital_name,
    MIN(ST_Distance(p.geom::geography, r.geom::geography)) AS nearest_road_distance_m,
    p.geom
FROM
    pois AS p
JOIN
    major_roads AS r
    ON ST_DWithin(p.geom::geography, r.geom::geography, 1000)
WHERE
    p.fclass = 'hospital'
    AND p.name IS NOT NULL
GROUP BY
    p.name, p.geom
ORDER BY
    nearest_road_distance_m ASC;
