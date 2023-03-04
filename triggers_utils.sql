# trigger de mise a jour spatial transferant le code insee d une commune entourant des points

-- https://georezo.net/forum/viewtopic.php?id=105619

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
  
