#!/bin/sh

export PATH=/home/fluent/.gem/ruby/2.3.0/bin:$PATH
export GEM_PATH=/home/fluent/.gem/ruby/2.3.0:$GEM_PATH
gem install fluent-plugin-elasticsearch  
exec fluentd -c /fluentd/etc/fluent.conf -p /fluentd/plugins ${FLUENTD_OPT}
