#!/bin/bash

echo "=================================================="
echo " Linux System Security Audit Script"
echo " Target Items: U-15, U-25"
echo "=================================================="

# [U-15] Check for files and directories with no owner
# Criteria: 'Vulnerable' if files with no UID or GID exist
echo "[U-15] Scanning for unowned files or groups..."
U15_RESULT=$(find / \( -nouser -o -nogroup \) -xdev 2>/dev/null)

if [ -z "$U15_RESULT" ]; then
    echo ">> Status: [SAFE] No unowned files found."
else
    echo ">> Status: [VULNERABLE] Unowned files/directories detected:"
    echo "$U15_RESULT"
fi

echo ""

# [U-25] Check for World Writable files
# Criteria: 'Vulnerable' if unnecessary world-writable files exist
echo "[U-25] Scanning for World Writable files..."
# Based on KISA guide: find / -type f -perm -2
U25_RESULT=$(find / -xdev -type f -perm -0002 2>/dev/null)

if [ -z "$U25_RESULT" ]; then
    echo ">> Status: [SAFE] No World Writable files found."
else
    echo ">> Status: [VULNERABLE] World writable files detected:"
    echo "$U25_RESULT"
fi

echo "=================================================="
echo " Audit Complete."
