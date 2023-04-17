-- ocs.intersection_ge_25_2010
CREATE TABLE ocs.intersection_ge_25_2010 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a inner join  ocs.ocs_ge_25_2010 as o on ST_Intersects(o.geom, a.geom)
where a.insee_dep = '25'

SELECT st_geometryType (geom), count(*), sum(ST_area(geom))/10000 as surf_ha FROM ocs.intersection_ge_25_2010 group by 1 order by 2 desc

/*
SELECT 273680
Query returned successfully in 47 secs 209 msec.
*/

CREATE TABLE ocs.intersection_ge_25_2017 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a inner join  ocs.ocs_ge_25_2017 as o on ST_Intersects(o.geom, a.geom)
where a.insee_dep = '25'

/*
ERROR: ERREUR:  lwgeom_intersection: GEOS Error: TopologyException: Input geom 1 is invalid: Self-intersection at or near point 924487.79772989417 6657646.2958461046 at 924487.79772989417 6657646.2958461046
SQL state: XX000
*/

CREATE TABLE ocs.intersection_ge_39_2010 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a inner join  ocs.ocs_ge_39_2010 as o on ST_Intersects(o.geom, a.geom)
where a.insee_dep = '39'

/*
SELECT 203483
Query returned successfully in 50 secs 282 msec.
*/


CREATE TABLE ocs.intersection_ge_39_2017 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a inner join  ocs.ocs_ge_39_2017 as o on ST_Intersects(o.geom, a.geom)
where a.insee_dep = '39'

/*
ERROR: ERREUR:  lwgeom_intersection: GEOS Error: TopologyException: Input geom 1 is invalid: Self-intersection at or near point 924487.79772989417 6657646.2958461046 at 924487.79772989417 6657646.2958461046
CONTEXT:  processus parallèle
SQL state: XX000
*/




/* Affectiation du caractere artificialise
*/
CASE  WHEN code_cs  =  'CS1.1.1.1' OR  code_cs=  'CS1.1.1.2' OR    
code_cs  =  'CS1.1.2.2' OR   code_cs  =  'CS1.1.2.1' AND  code_us = 'US1.3' OR 
(left( code_cs,7) = 'CS2.2.1' OR left( code_cs,7) = 'CS2.2.2') 
AND code_us IN ('US2' , 'US3' , 'US4.1.1' , 'US4.1.2' , 'US4.1.3' , 'US4.1.4' , 'US4.1.5',  'US4.2' ,'US4.3' , 'US5' , 'US6.1' , 'US6.2')  THEN 1 
ELSE 
END&#xd;&#xa;" symbol="0" key="{1bc6baef-29f5-4943-b4ce-1d04ca64aa82}" label="artificialisé"


-- methode integration 90 2017

DROP TABLE ocs.intersection_ge_90_2017;
CREATE TABLE ocs.intersection_ge_90_2017 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a , ocs.ocs_ge_90_2017 as o 
where a.insee_dep = '90'
/*
SELECT 19424724
Query returned successfully in 7 min 4 secs.
*/

DROP TABLE ocs.intersection_ge_21_2017;

CREATE TABLE ocs.intersection_ge_21_2017 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a , ocs.ocs_ge_21_2017 as o 
where a.insee_dep = '21'

/*SELECT 204340198
Query returned successfully in 1 hr 38 min.
*/

SELECT Populate_Geometry_Columns('ocs.intersection_ge_21_2017'::regclass);

-- il faut calculer les surface de l intersect
ALTER TABLE ocs.intersection_ge_21_2017
ADD surfacem2 integer;

UPDATE ocs.intersection_ge_21_2017 SET surfacem2=ST_AREA(geom);



-- 

CREATE TABLE ocs.intersection_ge_21_2017 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a , ocs.ocs_ge_21_2017 as o 
where a.insee_dep = '21'


--



select ocs_ge_21_2017_gid,
    ST_Multi(
        ST_Buffer(
            ST_Intersection(commune_r27.geom, ocs_ge_21_2017.geom),
            0.0
        )
    ) clipped_geom
from ign_ref.commune_r27
     inner join ocs_ge_21_2017 on ST_Intersects(commune_r27.geom, ocs_ge_21_2017.geom)
where not ST_IsEmpty(ST_Buffer(ST_Intersection(commune_r27.geom, ocs_ge_21_2017.geom), 0.0));

-- ocs.intersection_ge_21_2010
CREATE TABLE ocs.intersection_ge_21_2010 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a inner join  ocs.ocs_ge_21_2010 as o on ST_Intersects(o.geom, a.geom)
where a.insee_dep = '21'

-- verification du nombre d objet
select count(*) from ocs.intersection_ge_21_2010 -- 303556 (2010) VS 311098 (2017)
select count(*) from ocs.intersection_ge_21_2010


SELECT Populate_Geometry_Columns('ocs.intersection_ge_21_2010'::regclass);

-- where a.insee_dep = '21'
SELECT st_geometryType (geom) ,  count(*), sum(ST_area(geom)) FROM ocs.intersection_ge_21_2010
group by 1 order by 2 desc
/*
WHERE ST_GeometryType(geom) = 'ST_GeometryCollection' 
   OR ST_GeometryType(geom) = 'ST_MultiLineString'
*/

SELECT * FROM ocs.intersection_ge_21_2010 WHERE ST_GeometryType(geom) = 'ST_GeometryCollection' 


select insee_com, code_cs, code_us, sum(ST_area(geom)) from ocs.intersection_ge_21_2010 group by insee_com, code_cs, code_us

select * from ign_ref.batiment limit 10

/*
SELECT 303556
Query returned successfully in 58 secs 374 msec.
*/

CREATE TABLE ocs.intersection_ge_21_2017_v2 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a inner join  ocs.ocs_ge_21_2017 as o on ST_Intersects(o.geom, a.geom)
where a.insee_dep = '21'


-- verification du nombre d objet
select count(*) from ocs.intersection_ge_21_2017_v2 -- 311098
select count(*) from ocs.intersection_ge_21_2017


SELECT st_geometryType (geom), count(*), sum(ST_area(geom))/10000 as surf_ha FROM ocs.intersection_ge_21_2010 group by 1 order by 2 desc

-- where a.insee_dep = '21'
SELECT st_geometryType (geom) FROM ocs.intersection_ge_21_2010
WHERE ST_GeometryType(geom) = 'ST_GeometryCollection' 
   OR ST_GeometryType(geom) = 'ST_MultiLineString'


-- where a.insee_dep = '21'
SELECT st_geometryType (geom) FROM ocs.intersection_ge_21_2010
WHERE ST_GeometryType(geom) = 'ST_GeometryCollection' 
   OR ST_GeometryType(geom) = 'ST_MultiLineString'

select count(*) from ocs.intersection_ge_21_2010
-- 303556

-- generation des types de geom 
select st_geometryType (geom), count(*), sum(round(ST_AREA(geom)/10000)) from ocs.intersection_ge_21_2010
group by st_geometryType (geom) 

SELECT st_geometryType (geom), count(*) FROM ocs.intersection_ge_21_2010 group by 1
-- WHERE ST_GeometryType(geom) = 'ST_MultiPolygon' 

SELECT ST_IsValidReason(geom) from ocs.intersection_ge_21_2010 group by 1

-- select count(*) from ocs.intersection_ge_21_2017

-- reprendre les noms de colonnes
SELECT 'SELECT ' || array_to_string(ARRAY(SELECT 'a' || '.' || c.column_name
        FROM information_schema.columns As c
            WHERE table_name = 'intersection_ge_90_2010' 
            AND  c.column_name NOT IN('geom')
    ), ',') || ' FROM ocs.intersection_ge_70_2017  As a' As sqlstmt

-- SELECT a.id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,a.oge_id,a.code_cs,a.code_us,a.millesime,a.source,a.ossature,a.id_origine,a.code_or,a.surfacem2 FROM ocs.intersection_ge_70_2017  As a

-- dump les multipolygon en polygon
CREATE TABLE ocs.intersection_ge_21_2010_multi_to_simple AS 
(
	SELECT a.id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,a.oge_id,a.code_cs,a.code_us,a.millesime,a.source,a.ossature,a.id_origine,a.code_or,a.surfacem2, (ST_Dump(a.geom)).geom as geom 
	FROM ocs.intersection_ge_21_2010  As a  
	WHERE ST_GeometryType(geom) = 'ST_MultiPolygon' limit 1
	from ocs.intersection_ge_21_2010
);



SELECT Populate_Geometry_Columns('ocs.intersection_ge_90_2017'::regclass);

-- il faut calculer les surface de l intersect
ALTER TABLE ocs.intersection_ge_90_2017
ADD surfacem2 integer

UPDATE ocs.intersection_ge_90_2017 SET surfacem2=ST_AREA(geom)

DROP TABLE ocs.intersection_ge_90_2010;
CREATE TABLE ocs.intersection_ge_90_2010 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a , ocs.ocs_ge_90_2010 as o 
where a.insee_dep = '90'

SELECT Populate_Geometry_Columns('ocs.intersection_ge_90_2010'::regclass);


-- il faut calculer les surface de l intersect
ALTER TABLE ocs.intersection_ge_90_2010
ADD surfacem2 integer

UPDATE ocs.intersection_ge_90_2010 SET surfacem2=ST_AREA(geom)

-- generation des types de geom 
select st_geometryType (geom), count(*), sum(ST_AREA(geom)/10000) from ocs.intersection_ge_90_2010
group by st_geometryType (geom) 

SELECT * ,st_geometryType (geom) FROM ocs.intersection_ge_90_2010
WHERE ST_GeometryType(geom) = 'ST_GeometryCollection' 
   OR ST_GeometryType(geom) = 'ST_MultiLineString' limit 100;
   

select *, st_geometryType (geom)  from ocs.intersection_ge_90_2010 
WHERE ST_GeometryType(geom) != 'ST_Polygon' AND ST_GeometryType(geom) != 'ST_MultiPolygon'
AND ST_GeometryType(geom) != 'ST_GeometryCollection'
limit 5000

DELETE FROM ocs.intersection_ge_90_2010
WHERE ST_GeometryType(geom) != 'ST_Polygon' AND ST_GeometryType(geom) != 'ST_MultiPolygon'
AND ST_GeometryType(geom) != 'ST_GeometryCollection';

select ST_MemSize(geom), count(*) from ocs.intersection_ge_90_2010 group by  1;
select sum(ST_MemSize(geom)) from ocs.intersection_ge_90_2010 ;

select sum(ST_MemSize(geom))/1024/1024 as kb from ocs.ocs_ge_70_2011;
select sum(ST_MemSize(geom)) from ocs.intersection_ge_90_2010 ;

-- https://postgis.net/docs/ST_MemSize.html

-- https://georezo.net/forum/viewtopic.php?id=109866

SELECT ST_IsValidReason(geom) from ocs.intersection_ge_90_2010 group by 1

-- generation des types de geom 
select st_geometryType (geom), count(*), sum(ST_AREA(geom)/10000) from ocs.intersection_ge_90_2010
group by st_geometryType (geom) 



SELECT COUNT(CASE WHEN ST_NumGeometries(geom) > 1 THEN 1 END) AS multi_geom,
       COUNT(geom) AS total_geom
FROM ocs.intersection_ge_90_2010;

SELECT COUNT(CASE WHEN ST_NumGeometries(geom) > 1 THEN 1 END) AS multi_geom,
       COUNT(geom) AS total_geom
FROM ocs.intersection_ge_70_2017;

select st_geometryType (geom), count(*) from ocs.intersection_ge_70_2017
group by st_geometryType (geom) limit 100

select st_geometryType (geom) and ST_NumGeometries(geom) from ocs.intersection_ge_90_2010

select count(*) from ocs.ocs_ge_70_2017


-- la requete intersection :
DROP TABLE ocs.intersection_ge_70_2017;
CREATE TABLE ocs.intersection_ge_70_2017 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a , ocs.ocs_ge_70_2017 as o 
where a.insee_dep = '70'

SELECT Populate_Geometry_Columns('ocs.intersection_ge_70_2017'::regclass);

-- il faut calculer les surface de l intersect
ALTER TABLE ocs.intersection_ge_70_2017
ADD surfacem2 integer

UPDATE ocs.intersection_ge_90_2010 SET surfacem2=ST_AREA(geom)
/*
UPDATE 5538739
Query returned successfully in 2 min 35 secs.
*/



select count(*) from ocs.ocs_ge_70_2011
-- la requete intersection :
DROP TABLE ocs.intersection_ge_70_2011;
CREATE TABLE ocs.intersection_ge_70_2011 as
SELECT a.id as id_commune,a.insee_com,a.insee_dep,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.siren_epci,a.code_siren,
o.id as oge_id , o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or , 
ST_Intersection( a.geom , o.geom ) as geom from ign_ref.commune_r27 as a , ocs.ocs_ge_70_2011 as o 
where a.insee_dep = '70'

SELECT Populate_Geometry_Columns('ocs.intersection_ge_70_2017'::regclass);

-- il faut calculer les surface de l intersect
ALTER TABLE ocs.intersection_ge_70_2017
ADD surfacem2 integer

UPDATE ocs.intersection_ge_90_2010 SET surfacem2=ST_AREA(geom)

/*
SELECT 100000
Query returned successfully in 1 secs 637 msec.

SELECT 200000
Query returned successfully in 3 secs 429 msec.

SELECT 2000000
Query returned successfully in 37 secs 786 msec.

37 secondes pour environ 10 communes
539 communes => 340 * 30 = 10200 secondes = 170 minutes


192324
2000000
*/

SELECT Populate_Geometry_Columns('ocs.intersection_ge_90_2010'::regclass);
SELECT Populate_Geometry_Columns('ocs.intersection_ge_90_2017'::regclass);

/*
probleme de cle primaire
*/




SELECT 'SELECT ' || array_to_string(ARRAY(SELECT 'a' || '.' || c.column_name
        FROM information_schema.columns As c
            WHERE table_name = 'intersection_ge_70_2017' 
            AND  c.column_name NOT IN('geom')
    ), ',') || ' FROM ocs.intersection_ge_70_2017  As a' As sqlstmt


*/


select * from ign_ref.commune_r27 where
insee_dep = '70'

-- https://georezo.net/forum/viewtopic.php?id=67427



SELECT 'SELECT ' || array_to_string(ARRAY(SELECT 'a' || '.' || c.column_name
        FROM information_schema.columns As c
            WHERE table_name = 'commune_r27' 
            AND  c.column_name NOT IN('geom')
    ), ',') || ' FROM ign_ref.commune_r27  As a' As sqlstmt

/*
SELECT o.id,o.code_cs,o.code_us,o.millesime,o.source,o.ossature,o.id_origine,o.code_or FROM ocs.ocs_ge_70_2017  As o
*/

/*
SELECT a.id,a.insee_com,a.insee_arr,a.insee_col,a.insee_dep,a.insee_reg,a.population,a.surface_ha,a.date_creat,a.date_maj,a.date_app,a.date_conf,a.code_post,a.nom,a.cl_arrond,a.cl_collter,a.cl_depart,a.cl_region,a.capitale,a.date_rct,a.recenseur,a.siren_epci,a.id_ch_lieu,a.id_aut_adm,a.code_siren FROM ign_ref.commune_r27  As a
*/


/*
SELECT b.the_geom As bgeom, p.the_geom As pgeom, 
		ST_Intersection(b.the_geom, p.the_geom) As intersect_bp
	FROM buildings b INNER JOIN parcels p ON ST_Intersection(b,p)
	WHERE ST_Overlaps(b.the_geom, p.the_geom)
	LIMIT 1;
*/
SELECT routes.*, limites_communes.nom
FROM routes, limites_communes
WHERE ST_Intersects(routes.geom, limites_communes.geom);

-- recommandatiosn
/*
Pour optimiser la fonction ST_Intersection de PostGIS, voici quelques conseils :
    Utilisez un index spatial : L'utilisation d'un index spatial peut considérablement améliorer les performances de la fonction ST_Intersection. Assurez-vous que la table est indexée sur les colonnes qui contiennent les géométries pour lesquelles vous effectuez l'intersection.
    Simplifiez les géométries : Si vos géométries sont très complexes, elles peuvent ralentir la fonction ST_Intersection. Vous pouvez simplifier les géométries avec la fonction ST_Simplify avant de les intersecter.
    Utilisez des géométries régulières : Les géométries régulières, comme les polygones rectangulaires ou les cercles, sont plus faciles à traiter que les géométries complexes. Si possible, essayez de convertir vos géométries en formes régulières avant de les intersecter.
    Limitez la zone d'intersection : Si vous ne recherchez que les intersections dans une zone spécifique, vous pouvez utiliser une requête SQL pour limiter la zone d'intersection avant d'utiliser la fonction ST_Intersection.
    Évitez les intersections multiples : Si vos géométries contiennent des intersections multiples, cela peut ralentir la fonction ST_Intersection. Essayez d'éviter les intersections multiples en simplifiant les géométries ou en limitant la zone d'intersection.
	*/
