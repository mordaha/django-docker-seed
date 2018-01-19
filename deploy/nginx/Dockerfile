FROM nginx

COPY deploy/nginx/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/log/nginx

CMD ["nginx", "-g", "daemon off;"]
