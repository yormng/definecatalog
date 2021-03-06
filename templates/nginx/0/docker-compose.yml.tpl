version: '2'
services:
  nginx:
    image: nginx:latest
{{- if ne .Values.db_link ""}}
    external_links:
      - ${db_link}:db
{{- else}}
    links:
      - db:db
    ports:
    - ${http_port}:80
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${mysql_password}
      MYSQL_USER: ${mysql_user}
      MYSQL_PASSWORD: ${mysql_password}
      MYSQL_DATABASE: ${mysql_db}
    volumes:
      - nginx-db:/var/lib/mysql
{{- end}}
volumes:
  nginx-data:
    driver: ${volume_driver}
{{- if eq .Values.db_link ""}}
  nginx-db:
    driver: ${volume_driver}
{{- end}}
