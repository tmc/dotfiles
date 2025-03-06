#!/bin/bash
# netstat-diff.sh - Monitor network statistics changes over time
set -euo pipefail

# Take initial snapshot
netstat -s > ~/.netstat-s-output
echo "Initial snapshot taken. Waiting for 5 seconds..."

# First comparison after 5 seconds
sleep 5
echo "=== Changes after 5 seconds ==="
diff -u <(cat ~/.netstat-s-output) <(netstat -s)

# Second comparison after 5 more seconds
sleep 5
echo -e "\n=== Changes after 10 seconds ==="
diff -u <(cat ~/.netstat-s-output) <(netstat -s)