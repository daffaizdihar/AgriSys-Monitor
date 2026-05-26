#!/bin/bash

clear_report() {

    echo ""

    read -p "Yakin ingin menghapus database? (y/n): " confirm

    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then

        > "$DATA_FILE"

        echo "Database berhasil dihapus."

    else

        echo "Penghapusan dibatalkan."

    fi
}
