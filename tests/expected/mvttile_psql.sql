SELECT STRING_AGG(mvtl, '') AS mvt FROM (
  SELECT COALESCE(ST_AsMVT(t, 'housenumber', 4096, 'mvtgeometry'), '') as mvtl FROM (SELECT ST_Expand(ST_TileEnvelope(:zoom, :x, :y), 1252344.2714243282/2^:zoom) as ST_AsMVTGeom(geometry, ST_TileEnvelope(:zoom, :x, :y), 4096, 128, true) AS mvtgeometry, :zoom AS housenumber, NULLIF(tags->'name:en', '') AS "name:en", NULLIF(tags->'name:de', '') AS "name:de", NULLIF(tags->'name:cs', '') AS "name:cs", NULLIF(tags->'name_int', '') AS "name_int", NULLIF(tags->'name:latin', '') AS "name:latin", NULLIF(tags->'name:nonlatin', '') AS "name:nonlatin" FROM (SELECT 'name:en=>"enname"'::hstore as tags) AS tt) AS t
    UNION ALL
  SELECT COALESCE(ST_AsMVT(t, 'enumfield', 4096, 'mvtgeometry', 'osm_id'), '') as mvtl FROM (SELECT ST_TileEnvelope(:zoom, :x, :y) as ST_AsMVTGeom(geometry, ST_TileEnvelope(:zoom, :x, :y), 4096, 0, true) AS mvtgeometry, :zoom AS osm_id, 'foo' AS class) AS t
) AS all_layers

