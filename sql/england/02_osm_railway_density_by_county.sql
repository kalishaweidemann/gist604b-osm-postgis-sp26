-- Query 2: Railway density by county
-- Purpose: Calculate railway length and density by county using all railway feature classes.
-- Administrative boundary tag: OSM boundary=administrative

-- Check unique fclass values in adminareas_a 
-- Use administrative level value (in this case, level 6 for county) for WHERE clause
-- SELECT DISTINCT fclass, code FROM adminareas_a; 

-- Check unique fclass values in railways (including all types, no filtering)
-- SELECT DISTINCT fclass FROM railways;

WITH county_metrics AS (
    SELECT
        aa.name AS county_name,
        SUM(ST_Length(ST_Intersection(r.geom, aa.geom)::geography)) / 1000 AS total_rail_length_km,
        ST_Area(aa.geom::geography) / 1000000 AS county_area_sq_km,
        aa.geom AS geom
    FROM
        adminareas_a AS aa
    JOIN
        railways AS r
        ON ST_Intersects(aa.geom, r.geom)
    WHERE
        aa.fclass = 'admin_level6'
    GROUP BY
        aa.name, aa.geom
)

SELECT
    county_name,
    total_rail_length_km,
    county_area_sq_km,
    total_rail_length_km / county_area_sq_km AS rail_density_km_per_sq_km,
    geom
FROM
    county_metrics
ORDER BY
    rail_density_km_per_sq_km DESC;