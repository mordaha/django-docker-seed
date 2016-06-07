#!/bin/sh

# temporary exports, see: https://github.com/fluent/fluentd-docker-image/pull/32#issuecomment-224384428
export PATH=/home/fluent/.gem/ruby/2.3.0/bin:$PATH
export GEM_PATH=/home/fluent/.gem/ruby/2.3.0:$GEM_PATH

gem install fluent-plugin-elasticsearch
exec fluentd -c /fluentd/etc/fluent.conf -p /fluentd/plugins ${FLUENTD_OPT}
