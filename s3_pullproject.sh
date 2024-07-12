read -p "Git Acc: " GIT_ACC
read -p "Project Folder Name: " PROJECT_FOLDER_NAME
read -p "Domain: " DOMAIN
read -p "Local Port: " LOCAL_PORT
read -p "Inter Port: " INTER_PORT
cd /usr/www/
git clone https://github.com/$GIT_ACC/$PROJECT_FOLDER_NAME.git
if [ -d "$PROJECT_FOLDER_NAME/staticfiles" ]; then
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