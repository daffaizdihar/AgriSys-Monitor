#!/bin/bash

# =====================================================
# IMPORT MODULE
# =====================================================

source config.sh
source add_farm.sh
source view_data.sh
source clear_data.sh
source search_data.sh

# =====================================================
# MAIN MENU
# =====================================================

while true
do

    echo ""
    echo "================================================"
    echo "         SMART FARM MONITORING SYSTEM"
    echo "================================================"
    echo "1. Add Farm Data"
    echo "2. View Database"
    echo "3. Search Plant Data"
    echo "4. Clear Database"
    echo "5. Exit"
    echo "================================================"

    read -p "Choose Menu : " menu

    case $menu in

        1)
            calculate_farm_data
            ;;

        2)
            view_report
            ;;

        3)
            search_data
            ;;

        4)
            clear_report
            ;;

        5)
            echo ""
            echo "Program selesai..."
            break
            ;;

        *)
            echo ""
            echo "Menu tidak tersedia!"
            ;;
    esac
done
