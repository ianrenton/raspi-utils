certbot certonly --webroot -w /var/www/html -d mciserver.zapto.org
systemctl stop lighttpd
cat /etc/letsencrypt/live/mciserver.zapto.org/privkey.pem /etc/letsencrypt/live/mciserver.zapto.org/cert.pem > /etc/letsencrypt/live/mciserver.zapto.org/web.pem
systemctl start lighttpd
