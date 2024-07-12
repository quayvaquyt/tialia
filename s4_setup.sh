read -p "Project Folder Name: " PROJECT_FOLDER_NAME
read -p "Local Port: " LOCAL_PORT
cd /etc/systemd/system/
cat <<EOL > gunicorn-$PROJECT_FOLDER_NAME.service
[Unit]
Description=gunicorn $PROJECT_FOLDER_NAME
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/usr/www/$PROJECT_FOLDER_NAME
ExecStart=/usr/www/$PROJECT_FOLDER_NAME/venv/bin/gunicorn --access-logfile - --workers 4 --bind 127.0.0.1:$LOCAL_PORT $PROJECT_FOLDER_NAME.wsgi:application

[Install]
WantedBy=multi-user.target
EOL
sudo systemctl start gunicorn-$PROJECT_FOLDER_NAME
sudo systemctl enable gunicorn-$PROJECT_FOLDER_NAME

sudo systemctl status gunicorn-$PROJECT_FOLDER_NAME