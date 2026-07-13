FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
COPY 2.html /usr/share/nginx/html/2.html
COPY assets /usr/share/nginx/html/assets

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=5 \
  CMD wget -q --spider http://127.0.0.1:80/ || exit 1
