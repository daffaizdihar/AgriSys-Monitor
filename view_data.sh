#!/bin/bash

view_report() {

    echo ""
    echo "=============== FARM DATABASE ==============="

    if [ ! -s "$DATA_FILE" ]; then
        echo "Belum ada data."
        return
    fi

    cat "$DATA_FILE"
}