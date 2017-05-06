#!/bin/sh

# initialize the goiardi database and create the schemas with sqitch for
# postgres

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

createuser -h $POSTGRES_HOST -U $POSTGRES_USER $GOIARDI_USER
createdb -h $POSTGRES_HOST -U $POSTGRES_USER -O $GOIARDI_USER $GOIARDI_DB

cd /src/goiardi-schema/postgres

sqitch deploy db:pg://$POSTGRES_USER:@$POSTGRES_HOST/$GOIARDI_DB

sed 's/_GOIARDI_DB_/'$GOIARDI_DB'/g; s/_GOIARDI_USER_/'$GOIARDI_USER'/g;' < /supporting-files/alter-postgres.sql | psql -U $POSTGRES_USER -h $POSTGRES_HOST -d $GOIARDI_DB
