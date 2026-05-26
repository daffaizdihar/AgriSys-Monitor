#!/bin/bash

calculate_farm_data() {

    echo ""
    echo "================ ADD FARM DATA ================"

    echo "Daftar Tanaman:"
    echo "1. Terong"
    echo "2. Jagung"
    echo "3. Cabai"
    echo "4. Tomat"
    echo "5. Sawi"
    echo "6. Bayam"
    echo "7. Kangkung"
    echo "8. Kentang"
    echo "9. Wortel"
    echo "10. Kubis"

    echo ""

    read -p "Pilih tanaman [1-10] : " plant_choice

    if ! [[ "$plant_choice" =~ ^[0-9]+$ ]]; then
        echo "Input harus angka!"
        return
    fi

    if [ "$plant_choice" -lt 1 ] || [ "$plant_choice" -gt 10 ]; then
        echo "Pilihan tidak valid!"
        return
    fi

    echo ""
    read -p "Masukkan luas lahan (m2): " area

    if ! [[ "$area" =~ ^[0-9]+$ ]]; then
        echo "Luas lahan harus angka!"
        return
    fi

    case $plant_choice in

        1)
            plant_name="Terong"
            water=$(( area * 4 ))
            fertilizer=$(( area / 20))
            harvest_days=$(( 90 ))
            watering_schedule="1 kali sehari"
            fertilizing_schedule="14 hari sekali"
            ;;

        2)
            plant_name="Jagung"
            water=$(( area * 9 / 2 ))
            fertilizer=$(( area * 7 / 100 ))
            harvest_days=$(( 115 ))
            watering_schedule="1 kali sehari"
            fertilizing_schedule="14 hari sekali"
            ;;

        3)
            plant_name="Cabai"
            water=$(( area * 5 ))
            fertilizer=$(( area * 8 / 100 ))
            harvest_days=$(( 80 ))
            watering_schedule="2 kali sehari"
            fertilizing_schedule="20 hari sekali"
            ;;

        4)
            plant_name="Tomat"
            water=$(( area * 5 ))
            fertilizer=$(( area / 10 ))
            harvest_days=$(( 75 ))
            watering_schedule="1 kali sehari"
            fertilizing_schedule="14 hari sekali"
            ;;

        5)
            plant_name="Sawi"
            water=$(( area * 4 ))
            fertilizer=$(( area * 4 / 100 ))
            harvest_days=$(( 28 ))
            watering_schedule="2 kali sehari"
            fertilizing_schedule="14 hari sekali"
            ;;

        6)
            plant_name="Bayam"
            water=$(( area * 7 / 2 ))
            fertilizer=$(( area * 2 / 100 ))
            harvest_days=$(( 22 ))
            watering_schedule="2 kali sehari"
            fertilizing_schedule="10 hari sekali"
            ;;

        7)
            plant_name="Kangkung"
            water=$(( area * 6 ))
            fertilizer=$(( area * 2 / 100 ))
            harvest_days=$(( 28 ))
            watering_schedule="2 kali sehari"
            fertilizing_schedule="14 hari sekali"
            ;;

        8)
            plant_name="Kentang"
            water=$(( area * 9 / 2))
            fertilizer=$(( area / 10 ))
            harvest_days=$(( 105 ))
            watering_schedule="1 kali sehari"
            fertilizing_schedule="30 hari sekali"
            ;;

        9)
            plant_name="Wortel"
            water=$(( area * 4 ))
            fertilizer=$(( area / 25 ))
            harvest_days=$(( 100 ))
            watering_schedule="1 kali sehari"
            fertilizing_schedule="45 hari sekali"
            ;;

        10)
            plant_name="Kubis"
            water=$(( area * 9 / 2 ))
            fertilizer=$(( area * 9 / 100 ))
            harvest_days=$(( 80 ))
            watering_schedule="1 kali sehari"
            fertilizing_schedule="20 hari sekali"
            ;;
    esac

    current_date=$(date +"%Y-%m-%d")
    harvest_date=$(date -d "+$harvest_days days" +"%Y-%m-%d")

    echo ""
    echo "=============== HASIL MONITORING ==============="

    echo "Tanaman             : $plant_name"
    echo "Luas Lahan          : $area m2"
    echo "Kebutuhan Air       : $water Liter"
    echo "Kebutuhan Pupuk     : $fertilizer Kg"
    echo "Jadwal Penyiraman   : $watering_schedule"
    echo "Jadwal Pemupukan    : $fertilizing_schedule"
    echo "Estimasi Panen      : $harvest_date"

    {
        echo "=================================================="
        echo "Tanggal Input       : $current_date"
        echo "Tanaman             : $plant_name"
        echo "Luas Lahan          : $area m2"
        echo "Kebutuhan Air       : $water Liter"
        echo "Kebutuhan Pupuk     : $fertilizer Kg"
        echo "Jadwal Penyiraman   : $watering_schedule"
        echo "Jadwal Pemupukan    : $fertilizing_schedule"
        echo "Estimasi Panen      : $harvest_date"
    } >> "$DATA_FILE"

    echo ""
    echo "Data berhasil disimpan!"
}
