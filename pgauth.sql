CREATE SCHEMA pgbouncer  AUTHORIZATION pgbouncer;

CREATE OR REPLACE FUNCTION pgbouncer.get_auth(IN p_usename text)
  RETURNS TABLE(username text, password text) AS
$BODY$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;
 
    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
     WHERE usename = p_usename;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  ROWS 1000;
ALTER FUNCTION pgbouncer.get_auth(text)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION pgbouncer.get_auth(text) TO postgres;
GRANT EXECUTE ON FUNCTION pgbouncer.get_auth(text) TO grupo_lectura;
GRANT EXECUTE ON FUNCTION pgbouncer.get_auth(text) TO pgbouncer;
REVOKE ALL ON FUNCTION pgbouncer.get_auth(text) FROM public;

