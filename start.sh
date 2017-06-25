#!/bin/sh

USERS_FILE=/etc/dovecot/users

touch $USERS_FILE
chmod 640 $USERS_FILE
chgrp dovecot $USERS_FILE

while [ "$ACCOUNTS" ] ;do
    iter=${ACCOUNTS%%,*}
    
    account=${iter%%:*}
    password=${iter#*:}
    
    echo "Create a password for the new email user $account"
    passwd=$(printf "$password\n$password" | doveadm pw -s MD5-CRYPT -u $1)
    echo  "$account:$passwd" >> $USERS_FILE

    if [ ! -d /home/$account/Maildir/ ]; then
        mkdir /home/$account/Maildir/
        chown smtp:smtp -R /home/$account/Maildir/
    fi

    [ "$ACCOUNTS" = "$iter" ] && \
        ACCOUNTS='' || \
        ACCOUNTS="${ACCOUNTS#*,}"
done

syslogd
exec "$@"
