FROM reg.real-ai.cn/public/nginx:1.29.0
COPY dist/ /opt/frontend-demo/fe
COPY /nginx/nginx.conf.template /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
