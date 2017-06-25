# Simple Dovecot Docker Container

Simple and light container for an IMAP server.

This container is for use with the `tschwery/docker-postfix` container to
provide a simple mail system.

## Environment Variables

- `ACCOUNTS` - Comma-separated list of accounts in the form `account:password,account2:password2`

## Volumes

No volumes are defined. To have mails from a Postfix container, mount the
wanted maildir in the `smtp` home folder `/home/smtp` and enable the `smtp`
account in the env variables.

