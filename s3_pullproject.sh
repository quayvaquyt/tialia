read -p "Git Acc: " GIT_ACC
read -p "Project Folder Name: " PROJECT_FOLDER_NAME
read -p "Domain: " DOMAIN
cd /usr/www/
git clone https://github.com/$GIT_ACC/$PROJECT_FOLDER_NAME.git
cd /etc/nginx/sites-available/
cp /usr/www/$PROJECT_FOLDER_NAME/setting/$DOMAIN $DOMAIN
sudo ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/