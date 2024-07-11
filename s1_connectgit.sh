git config --global user.name "quayvaquyt"
git config --global user.email "quayvaquyt@gmail.com"
ssh-keygen -t rsa -b 4096 -C "quayvaquyt@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa.pub
cp ~/.ssh/id_rsa.pub /usr/www/tialia/staticfiles/git.txt
cp nginx /etc/nginx/sites-available/tialia
sudo ln -s /etc/nginx/sites-available/tialia /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
echo "Echo check :8000/staticfiles/git.txt
python3 manage.py runserver