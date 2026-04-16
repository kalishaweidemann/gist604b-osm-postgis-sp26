-- Query 1: Nature Reserve locations
-- Purpose: Extract all nature reserve polygons in England from OpenStreetMap (OSM) data.

-- Check unique fclass values in natural_a table 
-- SELECT DISTINCT fclass FROM protected_areas_a; 
-- SELECT COUNT(*) AS nature_reserve_rows FROM protected_areas_a WHERE fclass = 'nature_reserve';

SELECT 
    osm_id, code, geom
FROM 
    protected_areas_a
WHERE 
    fclass = 'nature_reserve';