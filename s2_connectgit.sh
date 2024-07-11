git config --global user.name "quayvaquyt"
git config --global user.email "quayvaquyt@gmail.com"
ssh-keygen -t rsa -b 4096 -C "quayvaquyt@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa.pub
cp ~/.ssh/id_rsa.pub /usr/www/tialia/id_rsa.pub
git remote add origin https://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@github.com/quayvaquyt/tialia.git
git add id_rsa.pub
git commit -m "id_rsa"
git push -u origin master