#!/bin/bash

clear_report() {
    echo ""
    echo "================ CLEAR DATABASE ================"
    echo "1. Hapus Seluruh Data"
    echo "2. Hapus Data Spesifik (Nama Tanaman & Luas)"
    echo "3. Batal"
    echo "================================================"
    
    read -p "Pilih opsi [1-3]: " clear_menu

    case $clear_menu in
        1)
            echo ""
            read -p "Yakin ingin menghapus seluruh database? (y/n): " confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                > "$DATA_FILE"
                echo "Database berhasil dihapus secara keseluruhan."
            else
                echo "Penghapusan dibatalkan."
            fi
            ;;
        2)
            echo ""
            read -p "Masukkan nama tanaman yang ingin dihapus : " del_plant
            read -p "Masukkan luas lahan (m2)                 : " del_area

            # Menggunakan awk untuk menyaring data. 
            # Data yang TIDAK cocok dengan kriteria akan ditulis ulang ke file sementara.
            awk -v plant="$del_plant" -v area="$del_area" '
            BEGIN { RS="==================================================\n" }
            {
                # Jika blok data tidak kosong dan TIDAK sesuai dengan kriteria yang ingin dihapus, simpan kembali
                if ($0 != "" && !($0 ~ "Tanaman             : "plant && $0 ~ "Luas Lahan          : "area" m2")) {
                    printf "==================================================\n%s", $0
                }
            }' "$DATA_FILE" > temp_db.txt

            # Timpa file database lama dengan file sementara yang sudah difilter
            mv temp_db.txt "$DATA_FILE"

            echo "Penghapusan selesai! Data '$del_plant' dengan luas '$del_area m2' telah dihapus."
            ;;
        3)
            echo "Kembali ke menu utama..."
            ;;
        *)
            echo "Pilihan tidak valid!"
            ;;
    esac
}
