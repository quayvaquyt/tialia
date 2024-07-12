ssh -T git@github.com
read -p "Remove tialia config? y|n: " REMOVE
if [ "$REMOVE" = "y" ]; then
    rm -f /etc/nginx/sites-available/tialia.service
    rm -f /etc/nginx/sites-enabled/tialia.service
    sudo nginx -t
    sudo systemctl restart nginx
    echo "Removed tialia.service"
fi