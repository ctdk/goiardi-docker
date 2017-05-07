#!/bin/sh

# initialize the goiardi database and create the schemas with sqitch for
# postgres

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

until psql -U $POSTGRES_USER -h $GOIARDI_POSTGRESQL_HOST -c '\l'; do
	>&2 echo "postgres still starting...."
	sleep 1
done

>&2 echo "postgres up - initializing database"

createuser -h $GOIARDI_POSTGRESQL_HOST -U $POSTGRES_USER $GOIARDI_POSTGRESQL_USERNAME
createdb -h $GOIARDI_POSTGRESQL_HOST -U $POSTGRES_USER -O $GOIARDI_POSTGRESQL_USERNAME $GOIARDI_POSTGRESQL_DBNAME

cd /src/goiardi-schema/postgres

sqitch deploy db:pg://$POSTGRES_USER:@$GOIARDI_POSTGRESQL_HOST/$GOIARDI_POSTGRESQL_DBNAME

sed 's/_GOIARDI_DB_/'$GOIARDI_POSTGRESQL_DBNAME'/g; s/_GOIARDI_USER_/'$GOIARDI_POSTGRESQL_USERNAME'/g;' < /supporting-files/alter-postgres.sql | psql -U $POSTGRES_USER -h $GOIARDI_POSTGRESQL_HOST -d $GOIARDI_POSTGRESQL_DBNAME

>&2 echo "finished initializing goiardi database"
