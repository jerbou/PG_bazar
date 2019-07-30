-- select * from public.n_zone_alea_mvt_gliss_horspprn_s_025 limit 10

-- SELECT ST_IsValidReason('LINESTRING(220227 150406,2220227 150407,222020 150410)');

SELECT ST_IsValidReason(geom) from public.n_zone_alea_mvt_gliss_horspprn_s_025 group by 1
SELECT ST_IsValidReason(geom), id from public.n_zone_alea_mvt_gliss_horspprn_s_025 group by 1,2

SELECT ST_IsValid(ST_GeomFromText('LINESTRING(0 0, 1 1)')) As good_line,

-- https://stackoverflow.com/questions/11894149/automatically-fixing-ring-self-intersections-in-shp2pgsql
	ST_IsValid(ST_GeomFromText('POLYGON((0 0, 1 1, 1 2, 1 1, 0 0))')) As bad_poly
	
SELECT ST_IsValidReason(ST_GeomFromText('POLYGON((0 0, 1 1, 1 2, 1 1, 0 0))'))


select st_geometryType (geom) from public.n_zone_alea_mvt_gliss_horspprn_s_025
group by st_geometryType (geom)

SELECT COUNT(CASE WHEN ST_NumGeometries(geom) > 1 THEN 1 END) AS multi_geom,
       COUNT(geom) AS total_geom
FROM public.n_zone_alea_mvt_gliss_horspprn_s_025;

-- Passe de multi a des polygones simples
CREATE TABLE public.n_zone_alea_mvt_gliss_horspprn_mulit_025 AS (
	SELECT id, id_map, id_zone, descript, coderisque, nomrisque, multi_alea, nivalea, nivalea_st, srce_geom, srce_annee, precision, titrecarte, datecarte, typecarte, nomfic, urlfic, indice, lib_indice, pente, nivo_pente, web_link, serv_prod, legende, niv_alea_l , (ST_Dump(geom)).geom as geom 
	from public.n_zone_alea_mvt_gliss_horspprn_s_025);

drop table valid_geoms_2

create table valid_geoms_2 as
	select id_map, id_zone, descript, coderisque, nomrisque, multi_alea, nivalea, nivalea_st, srce_geom, srce_annee, precision, titrecarte, datecarte, typecarte, nomfic, urlfic, indice, lib_indice, pente, nivo_pente, web_link, serv_prod, legende, niv_alea_l , ST_MakeValid(geom) as geom from
	public.n_zone_alea_mvt_gliss_horspprn_mulit_025

SELECT Populate_Geometry_Columns('valid_geoms'::regclass);

-- attention ne recupere que les identifiants TO IMPROVE
-- https://stackoverflow.com/questions/11894149/automatically-fixing-ring-self-intersections-in-shp2pgsql
drop table valid_geoms

create table valid_geoms as
	with make_valid (id, id_map, geom) as 
   (select 
      row_number() over() as id, id_map, id_zone, descript, coderisque, nomrisque, multi_alea, nivalea, nivalea_st, srce_geom, srce_annee, precision, titrecarte, datecarte, typecarte, nomfic, urlfic, indice, lib_indice, pente, nivo_pente, web_link, serv_prod, legende, niv_alea_l,
     (ST_Dump(ST_MakeValid(geom))).geom as geom2 from public.n_zone_alea_mvt_gliss_horspprn_s_025
  )
  select id, geom from make_valid where ST_GeometryType(geom2)='ST_Polygon';
-- id_map, id_zone, descript, coderisque, nomrisque, multi_alea, nivalea, nivalea_st, srce_geom, srce_annee, precision, titrecarte, datecarte, typecarte, nomfic, urlfic, indice, lib_indice, pente, nivo_pente, web_link, serv_prod, legende, niv_alea_l


/* traitement rapide en SELECT 217351
Query returned successfully in 45 secs 935 msec.
*/


