# Activity Counter

Project UTS Pemrograman Mobile – Aplikasi Activity Counter menggunakan **Flutter** dan arsitektur **MVVM** (Model, Data, Repository, ViewModel, View).

## Identitas Mahasiswa

| | |
|---|---|
| **Nama** | M. Faturahman N. M |
| **Kelas** | TI24M |
| **NIM** | 20240040262 |
| **Program Studi** | Teknik Informatika |

## Deskripsi

Aplikasi sederhana untuk mencatat dan menghitung aktivitas (contoh: Push Up, Baca Buku, Minum Air Putih). Pengguna dapat menambah, mengubah, dan menghapus aktivitas, serta menambah, mengurangi, dan mereset nilai counter. Data disimpan sementara dalam `List` selama aplikasi berjalan.

## Fitur

- **Home**: daftar aktivitas beserta nilai counter, tombol tambah, ketuk item untuk detail, ikon pensil untuk edit.
- **Tambah/Edit Aktivitas**: form input nama dengan validasi (tidak boleh kosong).
- **Detail Aktivitas**: tombol (+), (−), Reset, dan Hapus. Counter tidak bisa kurang dari 0.
- **Feedback**: SnackBar saat aktivitas ditambah/diubah/dihapus dan saat counter berubah; AlertDialog konfirmasi sebelum Reset dan Hapus.
- Tampilan diperbarui otomatis saat data berubah (`ChangeNotifier` + `ListenableBuilder`).

## Struktur Folder

```
lib/
├── main.dart
├── models/
│   └── activity_model.dart
├── data/
│   └── activity_data.dart
├── repositories/
│   └── activity_repository.dart
├── viewmodels/
│   └── activity_viewmodel.dart
└── views/
    ├── home_view.dart
    ├── activity_form_view.dart
    └── activity_detail_view.dart
```

## Arsitektur MVVM

| Lapisan | Tanggung jawab |
|---|---|
| **Model** | Struktur data aktivitas (`id`, `name`, `counter`). |
| **Data** | Sumber data sementara: data awal dan `List` aktivitas selama aplikasi berjalan. |
| **Repository** | Akses dan manipulasi data: ambil, tambah, ubah, hapus, dan perbarui counter. |
| **ViewModel** | Logika aplikasi dan state (`ChangeNotifier`); memanggil Repository lalu `notifyListeners()`. |
| **View** | Tampilan antarmuka (Home, Form, Detail); berinteraksi dengan ViewModel. |

### Alur Data

```
View  →  ViewModel  →  Repository  →  Data (List)
  ↑            |
  └────────────┘  notifyListeners() → View rebuild otomatis
```

1. Pengguna menekan tombol di **View**.
2. View memanggil fungsi di **ViewModel**.
3. ViewModel meminta **Repository** mengubah data.
4. Repository membaca/mengubah `List` di **Data**.
5. ViewModel memanggil `notifyListeners()`, sehingga **View** (`ListenableBuilder`) membangun ulang tampilan.

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

## Screenshot

### Halaman Home
![Home](screenshots/01_home.png)

### Halaman Tambah Aktivitas
![Tambah Aktivitas](screenshots/02_tambah_aktivitas.png)
![Home setelah tambah](screenshots/03_home_setelah_tambah.png)

### Halaman Detail Aktivitas
![Detail Push Up](screenshots/04_detail_push_up.png)
![Detail Baca Buku](screenshots/05_detail_baca_buku.png)
![Detail Minum Air](screenshots/06_detail_minum_air.png)

### Interaksi Counter
![Counter bertambah](screenshots/07_counter_tambah.png)
![Counter berkurang](screenshots/08_counter_kurang.png)

### Edit dan Validasi
![Validasi nama kosong](screenshots/09_validasi_nama_kosong.png)
![Edit berhasil](screenshots/10_edit_berhasil.png)

### Reset Counter
![Dialog Reset](screenshots/11_dialog_reset.png)
![Reset berhasil](screenshots/12_reset_berhasil.png)

### Hapus Aktivitas
![Dialog Hapus](screenshots/13_dialog_hapus.png)
![Hapus berhasil](screenshots/14_hapus_berhasil.png)


