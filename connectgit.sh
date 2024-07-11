git config --global user.name "quayvaquyt"
git config --global user.email "quayvaquyt@gmail.com"
ssh-keygen -t rsa -b 4096 -C "quayvaquyt@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa.pub
cp ~/.ssh/id_rsa.pub /usr/www/tialia/id_rsa.pub
git push