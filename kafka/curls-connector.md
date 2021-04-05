Examples:

You can use ip inside the machine or using DNS;

List connectors
```
curl -XGET --header "Content-Type: application/json" localhost:1234/connectors
```

Pause connector
```
curl -XPUT --header "Content-Type: application/json" localhost:1234/connectors/connector_name/pause
```

Restart an connector
```
curl -XPOST --header "Content-Type: application/json" localhost:1234/connectors/connector_name/tasks/0/restart
```

Resume an connector
```
curl -XPUT --header "Content-Type: application/json" localhost:1234/connectors/connector_name/resume
```

Delete an connector
```
curl -X DELETE localhost:1234/connectors/connector_name/
```


Creating a connector with configs:

```
curl -XPOST --header "Content-Type: application/json" localhost:1234/connectors -d '{
    "name": "connector_name",
    "config": {
        "name": "connector_name",
        "connector.class": "io.debezium.connector.mysql.MySqlConnector",
        "tasks.max": "1",
        "table.blacklist": "tables1,table2",
        "database.port": "database_port",
        "decimal.handling.mode": "double",
        "database.history.kafka.bootstrap.servers": "aws-sand-kafka-1.moip.in:9092,aws-sand-kafka-2.moip.in:9092,aws-sand-kafka-3.moip.in:9092",
        "database.history.kafka.topic": "debezium.schema.changes.financial",
        "database.server.name": "debezium",
        "database.hostname": "host",
        "database.password": "password",
        "database.user": "user",
        "database.whitelist": "financial",
        "snapshot.mode": "schema_only"
    }
}'
```

Itens:

- name: Name of your connector;
- connector.class: Name of your database connector class;
- tasks.max: Usually 1;
- table.blacklist: List of tables you won't take to look;
- database.port: database port;
- decimal.handling.mode: Usually double;
- database.history.kafka.bootstrap.servers: Brokers DNS or IP;
- database.history.kafka.topic: Topic name;
- database.server.name: Database server name;
- database.hostname: database host;
- database.password: database pass;
- database.user: database user;
- database.whitelist: List of tables that will be listened to send to the queue;
- snapshot.mode: Usually schema_only;
