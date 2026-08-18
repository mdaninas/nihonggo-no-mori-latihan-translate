# Nihongo no Mori

Aplikasi latihan **JLPT N3 文字・語彙** (huruf & kosakata) untuk Android. Versi **1.0.0**.

Berjalan **offline**. Ditemani Kapizamurai (カピ侍). Bahasa antarmuka: Indonesia.

## Unduh & pasang (Android)

1. Buka **[rilis v1.0.0](https://github.com/mdaninas/nihonggo-no-mori-latihan-translate/releases/tag/v1.0.0)** (atau [rilis terbaru](https://github.com/mdaninas/nihonggo-no-mori-latihan-translate/releases/latest)).
2. Unduh berkas **`NihongoNoMori-1.0.0.apk`**.
3. Di HP, izinkan pasang dari sumber tidak dikenal (Pengaturan → keamanan / pasang aplikasi tidak dikenal → izinkan untuk Chrome atau Files).
4. Buka APK yang baru diunduh, lalu ketuk **Pasang**.

Tidak lewat Play Store. Progress disimpan di perangkat (streak, XP, jawaban).

## Isi latihan (BAB I)

| Soal | Sub-bab | Jumlah |
| --- | --- | ---: |
| 1 | Membaca Kanji | 90 |
| 2 | Penulisan / Ejaan | 70 |
| 3 | Konteks Kalimat | 117 |
| 4 | Sinonim / Parafrase Kata | 50 |
| 5 | Penggunaan Kata | 54 |
| | **Total** | **381** |

Progres tiap sub-bab **terpisah**. Pilih jawaban dulu, lalu **Kirim**. Furigana dan terjemahan Indonesia bisa ditampilkan setelah menjawab.

## Fitur

- Streak, XP, dan level (10 XP per soal pertama; 100 XP per level)
- Mode gelap
- Furigana dan terjemahan yang bisa di-toggle
- Maskot Kapizamurai di beranda (progress XP tidak tertutup maskot)

## Jalankan dari kode sumber

Butuh [Flutter](https://docs.flutter.dev/get-started/install) (SDK 3.4+).

```sh
cd app
flutter pub get
flutter test
flutter run
```

APK rilis:

```sh
cd app
flutter build apk --release
```

Berkas keluar di `app/build/app/outputs/flutter-apk/app-release.apk`.

Proyek ini **tanpa paket runtime pihak ketiga** (hanya Flutter SDK). Foto halaman buku **tidak** ikut di APK.

## Hak cipta

Kode aplikasi (tampilan, logika latihan, terjemahan UI) berlisensi [MIT](LICENSE), © 2026 Muhammad.

Soal yang ditranskripsi dari buku **「JLPT N3 この一冊で合格する 日本語の森」** tetap hak cipta penulis dan penerbit. Dipakai untuk **belajar pribadi**. Jangan menyalin ulang bank soal tanpa izin pemegang hak.
