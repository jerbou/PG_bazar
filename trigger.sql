-- 1 : creation de la table points projeté en Lambert RGF 93 (EPSG : 2154)
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
