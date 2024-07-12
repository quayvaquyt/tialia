read -p "Git Acc: " GIT_ACC
read -p "Project Folder Name: " PROJECT_FOLDER_NAME
cd /usr/www
git clone https://github.com/$GIT_ACC/$PROJECT_FOLDER_NAME.git