-- Query 2: Railway length by county
-- Purpose: Calculate total railway length (in kilometers) within each county using all railway feature classes.
-- Administrative boundary tag: https://wiki.openstreetmap.org/wiki/Tag:boundary%3Dadministrative

-- Check unique fclass values in adminareas_a 
-- Use administrative level value (in this case, level 6 for county) for WHERE clause
-- SELECT DISTINCT fclass, code FROM adminareas_a; 

-- Check unique fclass values in railways (including all types, no filtering)
-- SELECT DISTINCT fclass FROM railways;

-- Intersect railways with admin boundaries and sum segment lengths
SELECT 
    aa.name AS county_name,
    SUM(ST_Length(ST_Intersection(aa.geom, r.geom)::geography)) / 1000 AS rail_length_km,
    aa.geom
FROM 
    adminareas_a AS aa
JOIN 
    railways AS r ON ST_Intersects(aa.geom, r.geom)
WHERE 
    aa.fclass = 'admin_level6'
GROUP BY 
    aa.name, aa.geom
ORDER BY 
    rail_length_km DESC;