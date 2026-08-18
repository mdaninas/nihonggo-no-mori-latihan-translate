const dailyMessages = <String>[
  'Langkah kecil hari ini, kanji jadi terasa dekat.',
  'Sedikit setiap hari, N3 makin dekat.',
  'Hari ini cukup satu sub-bab.',
  'Konsisten lebih penting daripada cepat.',
  'Furigana boleh dinyalakan. Yang penting terus baca.',
  'Satu soal benar sudah kemajuan.',
  'Jangan gabungkan semua jenis soal. Pilih satu, selesaikan.',
  'Kalau salah, baca lagi. Itu bagian belajarnya.',
];

String dailyMessageFor(DateTime now) => dailyMessages[now.difference(DateTime(now.year)).inDays % dailyMessages.length];
