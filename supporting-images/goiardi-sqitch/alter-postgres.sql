set search_path = '_GOIARDI_DB_';
ALTER USER _GOIARDI_USER_ WITH PASSWORD '_GOIARDI_PASSWORD_';
ALTER SCHEMA _GOIARDI_DB_ OWNER TO _GOIARDI_USER_;
ALTER SCHEMA _GOIARDI_DB__search_base OWNER TO _GOIARDI_USER_;
GRANT CREATE ON DATABASE _GOIARDI_DB_ TO _GOIARDI_USER_;

CREATE FUNCTION exec(text) returns text language plpgsql volatile
  AS $f$
    BEGIN
      EXECUTE $1;
      RETURN $1;
    END;
$f$;
SELECT exec('ALTER TABLE ' || quote_ident(s.nspname) || '.' ||
            quote_ident(s.relname) || ' OWNER TO _GOIARDI_USER_')
FROM (SELECT nspname, relname
          FROM pg_class c JOIN pg_namespace n ON (c.relnamespace = n.oid)
         WHERE nspname NOT LIKE E'pg\\_%' AND
               nspname <> 'information_schema' AND
               relkind IN ('r','S','v') ORDER BY relkind = 'S') s;
