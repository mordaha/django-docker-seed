FROM logstash:5

COPY deploy/logstash/logstash.conf /etc/logstash/conf.d/logstash.conf

# Add your logstash plugins setup here
# Example: RUN logstash-plugin install logstash-filter-json

CMD ["-f", "etc/logstash/conf.d/"]
