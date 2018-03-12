user  nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {

    server {
        listen    80;
        return    301 https://$host$request_uri;
    }

    server {
        listen 80;
        server_name ${SRV_NAME};

        access_log  /var/log/nginx/sentry.access.log;

        location / {
            proxy_set_header        Host $host;
            proxy_set_header        X-Real-IP $remote_addr;
            proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header        X-Forwarded-Proto $scheme;
            proxy_pass              http://web:9000;
            proxy_read_timeout      90;
            proxy_redirect          off;
        }

    }

}
