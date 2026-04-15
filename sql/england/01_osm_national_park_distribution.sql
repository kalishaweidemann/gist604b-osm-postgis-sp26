-- Query 1: National Parks
-- Purpose: Extract all national park polygons in England from OpenStreetMap (OSM) protected areas data.

-- Check unique fclass values in protect_areas_a shapefile
SELECT DISTINCT fclass
FROM protected_areas_a; 

-- Use national park fclass value for WHERE clause
SELECT geom
FROM protected_areas_a
WHERE fclass = 'national_park';