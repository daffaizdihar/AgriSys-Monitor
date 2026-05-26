# =========================================================
# SEARCH DATA BERDASARKAN TANAMAN, TANGGAL, DAN LUAS
# =========================================================

search_data() {

    echo ""

    read -p "Masukkan nama tanaman           : " keyword
    read -p "Masukkan tanggal input          : " search_date
    read -p "Masukkan luas lahan (m2)        : " search_area

    echo ""
    echo "================ HASIL PENCARIAN ================"

    # =====================================================
    # CARI DATA SESUAI PARAMETER
    # =====================================================

    result=$(awk \
    -v plant="$keyword" \
    -v date="$search_date" \
    -v area="$search_area" '

    BEGIN {
        RS="=================================================="
    }

    $0 ~ "Tanaman             : "plant &&
    $0 ~ "Tanggal Input       : "date &&
    $0 ~ "Luas Lahan          : "area" m2" {

        print $0
    }

    ' "$DATA_FILE")

    # =====================================================
    # JIKA DATA TIDAK DITEMUKAN
    # =====================================================

    if [ -z "$result" ]; then
        echo "Data tidak ditemukan."
        return
    fi

    echo "$result"

    echo ""
    echo "================ ESTIMASI MONITORING ================"

    # =====================================================
    # AMBIL DATA DARI DATABASE
    # =====================================================

    plant_name=$(echo "$result" | grep "Tanaman" | awk -F': ' '{print $2}')

    input_date=$(echo "$result" | grep "Tanggal Input" | awk -F': ' '{print $2}')

    harvest_date=$(echo "$result" | grep "Estimasi Panen" | awk -F': ' '{print $2}')

    watering_schedule=$(echo "$result" | grep "Jadwal Penyiraman" | awk -F': ' '{print $2}')

    fertilizing_schedule=$(echo "$result" | grep "Jadwal Pemupukan" | awk -F': ' '{print $2}')

    current_date=$(date +"%Y-%m-%d")

    # =====================================================
    # HITUNG HARI BERJALAN
    # =====================================================

    input_seconds=$(date -d "$input_date" +%s)

    current_seconds=$(date -d "$current_date" +%s)

    harvest_seconds=$(date -d "$harvest_date" +%s)

    days_passed=$(( (current_seconds - input_seconds) / 86400 ))

    remaining_days=$(( (harvest_seconds - current_seconds) / 86400 ))

    # =====================================================
    # VALIDASI PANEN
    # =====================================================

    if [ "$remaining_days" -lt 0 ]; then

        echo "Tanaman diperkirakan sudah panen."

        return

    fi

    # =====================================================
    # OUTPUT ESTIMASI
    # =====================================================

    echo "Tanaman              : $plant_name"
    echo "Hari ke              : $days_passed"
    echo "Sisa menuju panen    : $remaining_days hari"
    echo "Estimasi Panen       : $harvest_date"

    echo ""

    # =====================================================
    # JADWAL PENYIRAMAN
    # =====================================================

    echo "============== JADWAL PENYIRAMAN =============="

    if [[ "$watering_schedule" == "1 kali sehari" ]]; then

        interval=1

    elif [[ "$watering_schedule" == "2 kali sehari" ]]; then

        interval=1

    else

        interval=1

    fi

    next_watering=0

    watering_count=0

    while [ "$next_watering" -le "$remaining_days" ]
    do

        future_date=$(date -d "$current_date +$next_watering days" +"%Y-%m-%d")

        echo "- Penyiraman ke-$((watering_count + 1)) : $future_date"

        watering_count=$((watering_count + 1))

        next_watering=$((next_watering + interval))

    done

    echo ""
    echo "Total sisa penyiraman : $watering_count kali"

    echo ""

    # =====================================================
    # JADWAL PEMUPUKAN
    # =====================================================

    echo "============== JADWAL PEMUPUKAN =============="

    fertilize_interval=$(echo "$fertilizing_schedule" | grep -o '[0-9]\+')

    if [ -z "$fertilize_interval" ]; then

        fertilize_interval=7

    fi

    next_fertilize=0

    fertilize_count=0

    while [ "$next_fertilize" -le "$remaining_days" ]
    do

        future_date=$(date -d "$current_date +$next_fertilize days" +"%Y-%m-%d")

        echo "- Pemupukan ke-$((fertilize_count + 1)) : $future_date"

        fertilize_count=$((fertilize_count + 1))

        next_fertilize=$((next_fertilize + fertilize_interval))

    done

    echo ""
    echo "Total sisa pemupukan : $fertilize_count kali"
}
