FROM reg.real-ai.cn/public/nginx:1.29.0
COPY dist/ /opt/frontend-demo/fe
COPY ./nginx/nginx.conf /

CMD envsubst '$PROXY_PASS' < /nginx.conf.template > /etc/nginx/nginx.conf && \
  cat /etc/nginx/nginx.conf && nginx -g 'daemon off;'
