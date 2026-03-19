#!/bin/bash

set -e

VM_USER="..."  # указать имя виртуальной машины
VM_HOST="..."  # указать IP-адрес виртуальной машины
TARGET_DIR="/usr/local/bin"

ARTIFACTS=(
    "C3_SimpleBashUtils/cat/cat"
    "C3_SimpleBashUtils/grep/grep"
)

for file in "${ARTIFACTS[@]}"; do
    scp "$file" "$VM_USER@$VM_HOST:$TARGET_DIR" || {
        echo "Copy error for file $file"
        exit 1
    }
done

echo "All files have been copied successfully."

ssh "$VM_USER@$VM_HOST" "chmod +x $TARGET_DIR/cat $TARGET_DIR/grep"

echo "Placing artifacts is complete!"