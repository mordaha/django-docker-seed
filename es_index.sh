#!/bin/sh

curl -XPUT localhost:8020/_template/logstash_1 -H 'Content-Type: application/json' -d '
                           {
                             "template" : "logstash-*",
                             "mappings": {
                               "nginx": {
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
                                   "@tags": { "type": "keyword", "index": true },
                                   "@timestamp": { "type": "date", "index": true },

                                   "ip": { "type": "keyword", "index": true },
                                   "request_method": { "type": "keyword", "index": true },
                                   "request_uri": { "type": "keyword", "index": true },
                                   "request_length": { "type": "long", "index": true },
                                   "request_time": { "type": "float", "index": true },
                                   "status": { "type": "integer", "index": true },
                                   "bytes_sent": { "type": "long", "index": true },
                                   "referrer": { "type": "keyword", "index": true },
                                   "useragent": { "type": "keyword", "index": true },
                                   "gzip_ratio": { "type": "float", "index": true },
                                   "log_type": { "type": "keyword", "index": true },

                                   "@type": { "type": "keyword", "index": true }
                                 }
                               }
                             },
                             "settings": {
                               "index.fielddata.cache" : "node",
                               "index.refresh_interval": "5s",
                               "index.number_of_shards": "3",
                               "index.query.default_field": "querystring",
                               "index.routing.allocation.total_shards_per_node": "2"
                             }
                           }
                           '

echo "\n"

curl -XGET localhost:8020/_template/
