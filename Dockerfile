FROM flyway/flyway:latest-alpine

COPY ./flyway.example.conf  /flyway/conf/flyway.conf
COPY ./sql                  /flyway/sql

CMD [ "migrate" ]
