-- 1 : trigger de mise a jour spatial transferant le code insee d une commune entourant des points

-- source : https://georezo.net/forum/viewtopic.php?id=105619

CREATE OR REPLACE FUNCTION public.maj()
  RETURNS trigger AS
$BODY$
DECLARE
identifiant INTEGER;
BEGIN 
identifiant := NEW.id;
IF TG_OP = 'INSERT' or TG_OP = 'UPDATE' THEN
-- update public.points SET code_insee = NULL WHERE id_commune = id;    
  -- update public.points set code_insee = insee_com FROM ign_relative.commune where st_within(points.geom, commune.geom);
    UPDATE points
SET code_insee = commune.insee_com
FROM ign_relative.commune
WHERE ST_Contains(commune.geom, points.geom);
END IF;
return     NEW; 
END;$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION public.maj()
  OWNER TO postgres;
  
  CREATE TRIGGER trigger_maj
  AFTER INSERT OR UPDATE OF geom
  ON public.points
  FOR EACH ROW
  EXECUTE PROCEDURE public.maj();
  
-- 2 : creation de la table points projeté en Lambert RGF 93 (EPSG : 2154)
-- Table: public.points

-- DROP TABLE public.points;

CREATE TABLE public.points
(
    pkid integer NOT NULL DEFAULT nextval('points_pkid_seq'::regclass),
    longitude real,
    latitude real,
    geom geometry(Point,2154),
    CONSTRAINT points_pkey PRIMARY KEY (pkid)
)

TABLESPACE pg_default;

ALTER TABLE public.points
    OWNER to postgres;
-- Index: sidx_points_geom

-- DROP INDEX public.sidx_points_geom;

CREATE INDEX sidx_points_geom
    ON public.points USING gist
    (geom)
    TABLESPACE pg_default;

-- 2 creation du Trigger: location_points en degre decimaux
-- source : https://www.northrivergeographic.com/postgis-trigger-location

CREATE OR REPLACE FUNCTION update_location_func()
RETURNS TRIGGER AS $BODY$
BEGIN
NEW.longitude := st_x(st_transform(NEW.geom, 4326));
NEW.latitude := st_y(st_transform(NEW.geom, 4326));
RETURN NEW;
END;
$BODY$
language plpgsql;

CREATE TRIGGER location_points BEFORE insert or update
ON points FOR EACH ROW EXECUTE PROCEDURE
update_location_func();
