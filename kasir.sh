#!/bin/bash

# Program kasir sederhana untuk UAS Sistem Operasi
# Dibuat oleh Fadwa untuk kasir sederhana Warung Fadwa
# Fitur: menampilkan menu, menghitung total belanja, validasi input, dan kembalian

# Fungsi untuk menampilkan menu
display_menu() {
	echo "=== MENU WARUNG FADWA ==="
	echo "1. Soto Ayam	- Rp17000"
	echo "2. Bakso Urat	- Rp15000"
	echo "3. Pecel Lele	- Rp20000"
	echo "4. Kopi Hitam	- Rp7000"
	echo "5. Jus Alpukat	- Rp8000"
	echo " "
}

# Aray untuk menyimpan nama menu dan harga
menu_names=("Soto Ayam" "Bakso Urat" "Pecel Lele" "Kopi Hitam" "Jus Alpukat")
menu_price=(17000 15000 20000 7000 8000)

# Fungsi untuk validasi input nomor menu
validate_menu() {
	local choice=$1
	if [[ ! $choice =~ ^[1-5]$ ]]; then
		echo "Pilihan menu tidak valid! Harus antara 1-5. "
		exit 1
	fi
}

# Fungsi untuk validasi input jumlah porsi
validate_quantity() {
	local qty=$1
	if [[ ! $qty =~ ^[0-9]+$ || $qty -lt 1 ]]; then
		echo "Jumlah porsi tidak valid! Harus angkat positif."
		exit 1
	fi
}

# Fungsi untuk validasi jumlah uang
validate_payment() {
	local payment=$1
	if [[ ! $payment =~ ^[0-9]+$ || $payment -lt 0 ]]; then
		echo "Jumlah uang tidak valid! Harus angka non-negatif."
		exit 1
	fi
}

# Inisialisasi total belanja
total=0

# Tampilkan menu
display_menu

# Input jumlah item
echo -n "Berapa item yang ingin dibeli? "
read num_items

# Validasi jumlah item
if [[ ! $num_items =~ ^[0-9]+$ || $num_items -lt 1 ]]; then
	echo "Jumlah item tidak valid! Harus angka positif."
	exit 1
fi

# Loop untuk setiap item
for ((i=1; i<=num_items; i++)); do
	echo " "
	echo "Item ke-$i:"
	echo -n  "Pilih menu (1-5): "
	read choice
	validate_menu $choice

	echo -n "Jumlah porsi: "
	read quantity
	validate_quantity $quantity

	# Hitung subtotal
	menu_index=$((choice-1))
	subtotal=$((menu_price[menu_index] * quantity))
	total=$((total + subtotal))

	# Tampilkan detail pesanan
	echo "Pesanan: ${menu_names[menu_index]} x $quantity = Rp$subtotal"
done

# Tampilkan total belanja
echo " "
echo "Total belanja: Rp$total"

# Input jumlah uang yang dibayarkan
echo -n "Masukan jumlah uang: "
read payment
validate_payment $payment

# Hitung dan validasi kembalian
change=$((payment - total))
if [ $change -lt 0 ]; then
	echo "Uang tidak cukup!"
	exit 1
else
	echo "Kembalian: Rp$change"
	echo "=== Terima kasih telah berbelanja di Warung Fadwa! ==="
fi
