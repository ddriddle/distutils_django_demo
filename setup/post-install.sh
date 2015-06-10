# Replace the users crontab
crontab <<EOF
# synchronize the developer keys
15 00,12 * * * /usr/bin/sdg_sync >/dev/null 2>&1

# django session cleanup
0 1 * * * python ~/share/python/contactsdatabase/manage.pyc clearsessions
EOF
