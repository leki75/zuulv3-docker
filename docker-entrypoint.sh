#!/bin/bash
set -e

chown -R zuul:zuul /var/lib/zuul
chmod 755 /var/lib/zuul

exec "$@"
