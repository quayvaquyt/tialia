read -p "Git Acc: " GIT_ACC
read -p "Project Folder Name: " PROJECT_FOLDER_NAME
read -p "Domain: " DOMAIN
read -p "Local Port: " LOCAL_PORT
read -p "Inter Port: " INTER_PORT
cd /usr/www/
git clone https://github.com/$GIT_ACC/$PROJECT_FOLDER_NAME.git
if [ -d "$PROJECT_FOLDER_NAME/staticfiles" ]; then
        echo "staticfiles folder already exists"
    else
        mkdir -p "$PROJECT_FOLDER_NAME/staticfiles"
        echo "Created project directory: $PROJECT_FOLDER_NAME/staticfiles"
    fi
cd /etc/nginx/sites-available/
cat <<EOL > $DOMAIN
server {
    listen $INTER_PORT;
    server_name $DOMAIN;

    location / {
        proxy_pass http://127.0.0.1:$LOCAL_PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    location /static/ {
        alias /usr/www/$PROJECT_FOLDER_NAME/static/;
    }

    location /staticfiles/ {
        alias /usr/www/$PROJECT_FOLDER_NAME/staticfiles/;
    }
}
EOL
echo  "Created NGINX Config for $DOMAIN"
sudo ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
cd /usr/www/$PROJECT_FOLDER_NAME
python3 -m venv venv
source venv/bin/activate
pip install gunicorn
deactivate

cd /etc/systemctl/system/
cat <<EOL > gunicorn-$PROJECT_FOLDER_NAME.service
[Unit]
Description=gunicorn $PROJECT_FOLDER_NAME
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/usr/www/$PROJECT_FOLDER_NAME
ExecStart=/usr/www/$PROJECT_FOLDER_NAME/venv/bin/gunicorn --access-logfile - --workers 20 --bind 127.0.0.1:$LOCAL_PORT $PROJECT_FOLDER_NAME.wsgi:application

[Install]
WantedBy=multi-user.target
EOL
sudo systemctl start gunicorn-$PROJECT_FOLDER_NAME
sudo systemctl enable gunicorn-$PROJECT_FOLDER_NAME

sudo systemctl status gunicorn-$PROJECT_FOLDER_NAME