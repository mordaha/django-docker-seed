#!/bin/sh

curl -XPUT localhost:8020/_template/logstash_1 -H 'Content-Type: application/json' -d '
                           {
                             "mappings": {
                               "_default_": {
                                 "_source": { },
                                 "properties" : {
                                   "event_data": { "type": "object" },
                                   "@fields": { "type": "object", "dynamic": true },
                                   "@message": { "type": "text", "index": true },
                                   "@source": { "type": "text", "index": true },
                                   "@source_host": { "type": "text", "index": true },
                                   "@source_path": { "type": "text", "index": true },
                                   "@level": { "type": "text", "index": true },
                                   "@sys_name": { "type": "text", "index": true },
                                   "@tags": { "type": "text", "index": true },
                                   "@timestamp": { "type": "date", "index": true },
                                   "@type": { "type": "text", "index": true }
                                 }
                               }
                             },
                             "settings": {
                               "index.fielddata.cache" : "node",
                               "index.refresh_interval": "5s",
                               "index.number_of_shards": "3",
                               "index.query.default_field": "querystring",
                               "index.routing.allocation.total_shards_per_node": "2"
                             },
                             "template": "logstash-*"
                           }
                           '

echo "\n"

curl -XGET localhost:8020/_template/
