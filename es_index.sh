#!/bin/sh

curl -XPUT localhost:8020/_template/logstash_1 -d '
                           {
                             "mappings": {
                               "_default_": {
                                 "_all": { "enabled": false },
                                 "_source": { },
                                 "properties" : {
                                   "event_data": { "type": "object" },
                                   "@fields": { "type": "object", "dynamic": true },
                                   "@message": { "type": "string", "index": "analyzed" },
                                   "@source": { "type": "string", "index": "not_analyzed" },
                                   "@source_host": { "type": "string", "index": "not_analyzed" },
                                   "@source_path": { "type": "string", "index": "not_analyzed" },
                                   "@level": { "type": "string", "index": "not_analyzed" },
                                   "@sys_name": { "type": "string", "index": "not_analyzed" },
                                   "@tags": { "type": "string", "index": "not_analyzed" },
                                   "@timestamp": { "type": "date", "index": "not_analyzed" },
                                   "@type": { "type": "string", "index": "not_analyzed" }
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
