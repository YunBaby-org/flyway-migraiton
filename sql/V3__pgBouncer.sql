/* The role "pgbouncer" is used to get authentication info from specific user */
/* pgbouncer require these information in order to access the database */
DO $$
BEGIN
    CREATE ROLE "pgbouncer" WITH LOGIN PASSWORD '${PGBOUNCER_ROLE_PASSWORD}';
    EXCEPTION WHEN DUPLICATE_OBJECT THEN
        RAISE NOTICE 'Role - pgbouncer already exists';
END
$$;
CREATE SCHEMA IF NOT EXISTS "pgbouncer" AUTHORIZATION "pgbouncer";

/* Create a function to retrieve those information */
CREATE OR REPLACE FUNCTION pgbouncer.get_auth(p_usename TEXT)
RETURNS TABLE(usename TEXT, passwd TEXT) AS
$$
BEGIN
    RAISE WARNING 'PgBouncer Auth Request: %', p_usename;

    RETURN QUERY
        SELECT shd.usename::TEXT, shd.passwd::TEXT FROM pg_catalog.pg_shadow AS shd
            WHERE shd.usename = p_usename;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

/* Make sure only the role pgbouncer can call this function */
REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename TEXT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION pgbouncer.get_auth(p_usename TEXT) TO pgbouncer;
