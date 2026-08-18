import '../models/question.dart';

/// JLPT N3 reading items transcribed from book pages 58–66.
///
/// Sentences use `漢字[かな]` markup so every kanji span can show furigana.
final questions = <Question>[
  // Page 58
  _q(1, 58, '秋[あき]になり、葉[は]の色[いろ]が変[か]わってきた。', '葉', 'は', 'Ketika musim gugur tiba, warna {daun} mulai berubah.', ['えだ', 'き', 'は', 'ね'], 2),
  _q(2, 58, '昨日[きのう]の夜[よる]、熱[ねつ]が出[で]た。', '熱', 'ねつ', 'Tadi malam, saya {demam}.', ['けむり', 'ねつ', 'ひ', 'ゆ'], 1),
  _q(3, 58, '庭[にわ]の木[き]に赤[あか]い実[み]がなりました。', '実', 'み', '{Buah} merah tumbuh di pohon di halaman.', ['たね', 'はな', 'め', 'み'], 3),
  _q(4, 58, '本棚[ほんだな]の角[かど]で頭[あたま]を打[う]った。', '角', 'かど', 'Saya membenturkan kepala pada {sudut} rak buku.', ['はし', 'よこ', 'かど', 'さき'], 2),
  _q(5, 58, '本[ほん]の表[おもて]に名前[なまえ]を書[か]く。', '表', 'おもて', 'Saya menulis nama di {sampul depan} buku.', ['おもて', 'うら', 'した', 'うえ'], 0),
  _q(6, 58, '寒[さむ]すぎて、指[ゆび]が冷[つめ]たくなった。', '指', 'ゆび', 'Karena terlalu dingin, {jari-jari} saya menjadi dingin.', ['て', 'あし', 'ゆび', 'うで'], 2),
  _q(7, 58, '母[はは]からきれいな器[うつわ]をもらいました。', '器', 'うつわ', 'Saya menerima {wadah} yang indah dari ibu.', ['なべ', 'さら', 'うつわ', 'いた'], 2),
  _q(8, 58, '卵[たまご]と粉[こな]を容器[ようき]に入[い]れて、よくかきまぜる。', '粉', 'こな', 'Masukkan telur dan {tepung} ke dalam wadah, lalu aduk rata.', ['す', 'あぶら', 'しお', 'こな'], 3),
  _q(9, 58, '演奏会[えんそうかい]の席[せき]を取[と]る。', '席', 'せき', 'Memesan {tempat duduk} untuk konser.', ['せき', 'ゆか', 'いす', 'ば'], 0),
  _q(10, 58, '荷物[にもつ]を箱[はこ]に入[い]れる。', '箱', 'はこ', 'Memasukkan barang bawaan ke dalam {kotak}.', ['かご', 'はこ', 'たんす', 'かばん'], 1),

  // Page 59
  _q(11, 59, '小[ちい]さい虫[むし]が列[れつ]になって歩[ある]いている。', '列', 'れつ', 'Serangga kecil berjalan dalam satu {barisan}.', ['れつ', 'たて', 'ななめ', 'せん'], 0),
  _q(12, 59, '缶[かん]をごみ箱[ばこ]に捨[す]てる。', '缶', 'かん', 'Membuang {kaleng} ke tempat sampah.', ['ふくろ', 'かみ', 'ふく', 'かん'], 3),
  _q(13, 59, 'わたしの机[つくえ]に置[お]いておいてください。', '机', 'つくえ', 'Tolong letakkan di {meja} saya.', ['だい', 'いす', 'つくえ', 'へや'], 2),
  _q(14, 59, '冬[ふゆ]は寒[さむ]くて、外[そと]に出[で]ると鼻[はな]が赤[あか]くなってしまう。', '鼻', 'はな', 'Saat musim dingin, {hidung} saya menjadi merah ketika keluar.', ['みみ', 'ほほ', 'はな', 'かお'], 2),
  _q(15, 59, '用紙[ようし]にきれいな線[せん]を書[か]く。', '線', 'せん', 'Menggambar {garis} yang rapi pada kertas.', ['まる', 'せん', 'え', 'じ'], 1),
  _q(16, 59, 'わたしは絵[え]や音楽[おんがく]などの芸術[げいじゅつ]が好[す]きだ。', '芸術', 'げいじゅつ', 'Saya menyukai {seni} seperti gambar dan musik.', ['げじゅつ', 'げしゅつ', 'げいじゅつ', 'げいしゅつ'], 2),
  _q(17, 59, 'わたしと野田[のだ]さんの間[あいだ]には熱[あつ]い友情[ゆうじょう]がある。', '友情', 'ゆうじょう', 'Ada {persahabatan} yang kuat antara saya dan Noda-san.', ['ゆうじょ', 'ゆうじょう', 'ゆじょ', 'ゆじょう'], 1),
  _q(18, 59, '自転車[じてんしゃ]の修理[しゅうり]をするには、様々[さまざま]な道具[どうぐ]が必要[ひつよう]です。', '道具', 'どうぐ', 'Untuk memperbaiki sepeda, diperlukan berbagai {peralatan}.', ['どうう', 'どぐ', 'どうぐう', 'どうぐ'], 3),
  _q(19, 59, '正[ただ]しい方角[ほうがく]を調[しら]べてから行[い]こう。', '方角', 'ほうがく', 'Mari periksa {arah} yang benar sebelum pergi.', ['ほうがく', 'ほかく', 'ほうかく', 'ほがく'], 0),
  _q(20, 59, '祖母[そぼ]の家[いえ]には楽器[がっき]がたくさんあります。', '楽器', 'がっき', 'Di rumah nenek ada banyak {alat musik}.', ['がつき', 'がつぎ', 'がっき', 'がっぎ'], 2),

  // Page 60
  _q(21, 60, 'さっき電話[でんわ]で10人[にん]分[ぶん]の注文[ちゅうもん]を受[う]けました。', '注文', 'ちゅうもん', 'Tadi saya menerima {pesanan} untuk sepuluh orang lewat telepon.', ['ちゅうぶん', 'ちゅぶん', 'ちゅうもん', 'ちゅもん'], 2),
  _q(22, 60, '日本[にほん]の箸[はし]を作[つく]っている人[ひと]は、高[たか]い技術[ぎじゅつ]を持[も]っている。', '技術', 'ぎじゅつ', 'Orang yang membuat sumpit Jepang memiliki {keterampilan} tinggi.', ['きしゅつ', 'ぎじゅつ', 'きしゅつ', 'ぎしゅつ'], 1),
  _q(23, 60, '高校[こうこう]時代[じだい]は野球[やきゅう]をしていました。', '野球', 'やきゅう', 'Saat SMA saya bermain {bisbol}.', ['やくう', 'やく', 'やきゅう', 'やきゅ'], 2),
  _q(24, 60, '辞書[じしょ]を使[つか]って調[しら]べる。', '辞書', 'じしょ', 'Mencari dengan menggunakan {kamus}.', ['じしょ', 'じしょう', 'ししょ', 'ししょう'], 0),
  _q(25, 60, '医者[いしゃ]から病気[びょうき]についての説明[せつめい]を受[う]ける。', '説明', 'せつめい', 'Menerima {penjelasan} tentang penyakit dari dokter.', ['せつめ', 'せつめ', 'せつめい', 'せつめい'], 3),
  _q(26, 60, '大学[だいがく]の合格[ごうかく]発表[はっぴょう]が行[おこな]われた。', '発表', 'はっぴょう', '{Pengumuman} kelulusan universitas telah dilakukan.', ['はっぴょ', 'はぴょ', 'はっぴょう', 'はぴょう'], 2),
  _q(27, 60, '柔道[じゅうどう]の初級[しょきゅう]の試験[しけん]に合格[ごうかく]した。', '初級', 'しょきゅう', 'Saya lulus ujian tingkat {pembula} judo.', ['しょうきゅう', 'しょきゅう', 'しょうきゅ', 'しょきゅ'], 1),
  _q(28, 60, '天気[てんき]がいいので布団[ふとん]を干[ほ]しましょう。', '布団', 'ふとん', 'Karena cuacanya bagus, mari jemur {futon}.', ['ぶとん', 'ふとん', 'ぶたん', 'ふだん'], 1),
  _q(29, 60, '通路[つうろ]が狭[せま]くて通[とお]れません。', '通路', 'つうろ', '{Lorongnya} sempit sehingga tidak bisa dilewati.', ['つうろ', 'つうろう', 'つろう', 'つろ'], 0),
  _q(30, 60, '進学[しんがく]のことについて、先生[せんせい]に相談[そうだん]があります。', '相談', 'そうだん', 'Saya ingin {berkonsultasi} dengan guru tentang melanjutkan sekolah.', ['そうたん', 'しょうたん', 'そうだん', 'しょうだん'], 2),

  // Page 61
  _q(31, 61, '来年[らいねん]は大阪[おおさか]の支店[してん]で働[はたら]くことを希望[きぼう]します。', '希望', 'きぼう', 'Tahun depan saya {berharap} dapat bekerja di cabang Osaka.', ['きぼう', 'きぼ', 'きいぼ', 'きいぼう'], 0),
  _q(32, 61, '弟[おとうと]は来年[らいねん]の3月[がつ]に大学[だいがく]を卒業[そつぎょう]する予定[よてい]です。', '卒業', 'そつぎょう', 'Adik laki-laki saya dijadwalkan {lulus} universitas pada Maret tahun depan.', ['そつぎょ', 'そっぎょ', 'そつぎょう', 'そっぎょう'], 3),
  _q(33, 61, 'ずっと食[た]べたかったカレーを食[た]べられて満足[まんぞく]した。', '満足', 'まんぞく', 'Saya {puas} karena akhirnya bisa makan kari yang sudah lama ingin saya makan.', ['まんそく', 'まんぞく', 'まんそぐ', 'まんぞぐ'], 1),
  _q(34, 61, 'わたしはプロの歌手[かしゅ]として、10年[ねん]間[かん]活動[かつどう]しています。', '活動', 'かつどう', 'Saya telah {aktif} sebagai penyanyi profesional selama sepuluh tahun.', ['かっとう', 'かつど', 'かつどう', 'かっど'], 2),
  _q(35, 61, '生徒[せいと]を代表[だいひょう]してあいさつをする。', '代表', 'だいひょう', 'Memberi sambutan sebagai {perwakilan} siswa.', ['たいひょう', 'だいひょう', 'たいひょ', 'だいひょ'], 1),
  _q(36, 61, '先生[せんせい]はわたしの考[かんが]えを否定[ひてい]した。', '否定', 'ひてい', 'Guru {menyangkal} pendapat saya.', ['ひてい', 'ひて', 'ふてい', 'ふて'], 0),
  _q(37, 61, 'ガソリンをたくさん消費[しょうひ]した。', '消費', 'しょうひ', '{Menghabiskan} banyak bensin.', ['そひ', 'そうひ', 'しょひ', 'しょうひ'], 3),
  _q(38, 61, '想定[そうてい]していなかった問題[もんだい]が起[お]きた。', '想定', 'そうてい', 'Masalah yang tidak {diperkirakan} terjadi.', ['そうてい', 'しょうてい', 'そうて', 'しょうて'], 0),
  _q(39, 61, '歯医者[はいしゃ]の予約[よやく]をする。', '予約', 'よやく', 'Membuat {janji} dengan dokter gigi.', ['ぞうやく', 'ぞやく', 'よやく', 'ようやく'], 2),
  _q(40, 61, '学校[がっこう]に携帯電話[けいたいでんわ]を持[も]ってくることを禁止[きんし]します。', '禁止', 'きんし', 'Membawa ponsel ke sekolah {dilarang}.', ['きんじ', 'ぎんじ', 'ぎんし', 'きんし'], 3),

  // Page 62
  _q(41, 62, '今回[こんかい]の事件[じけん]は、前回[ぜんかい]の事件[じけん]と関係[かんけい]しているようだ。', '関係', 'かんけい', 'Tampaknya kejadian ini {berhubungan} dengan kejadian sebelumnya.', ['かんけ', 'かんげ', 'かけい', 'かんけい'], 3),
  _q(42, 62, '今年[ことし]は赤[あか]のチームが優勝[ゆうしょう]しました。', '優勝', 'ゆうしょう', 'Tahun ini tim merah menjadi {juara}.', ['ゆしょう', 'ゆうしょう', 'ゆうしょ', 'ゆしょ'], 1),
  _q(43, 62, '昨日[きのう]、足[あし]を手術[しゅじゅつ]しました。', '手術', 'しゅじゅつ', 'Kemarin saya menjalani {operasi} kaki.', ['しゅうしゅつ', 'しゅうじゅつ', 'しゅしゅつ', 'しゅじゅつ'], 3),
  _q(44, 62, '大事[だいじ]な日[ひ]なのに、失敗[しっぱい]してしまいました。', '失敗', 'しっぱい', 'Walau hari penting, saya melakukan {kesalahan}.', ['しっぱい', 'しばい', 'しっばい', 'しはい'], 2),
  _q(45, 62, 'わたしは仕事[しごと]でバスを運転[うんてん]しています。', '運転', 'うんてん', 'Dalam pekerjaan saya {mengemudikan} bus.', ['うてん', 'うんてん', 'うんて', 'うってん'], 1),
  _q(46, 62, '机[つくえ]を引[ひ]いてください。', '引', 'ひ', 'Tolong {tarik} mejanya.', ['ふいて', 'たたいて', 'ひいて', 'おいて'], 2),
  _q(47, 62, 'これは駐車場[ちゅうしゃじょう]を表[あらわ]すマークです。', '表す', 'あらわす', 'Ini adalah tanda yang {menunjukkan} tempat parkir.', ['しめす', 'さす', 'かす', 'あらわす'], 3),
  _q(48, 62, '大[おお]きな段[だん]ボール箱[ばこ]を届[とど]ける。', '届ける', 'とどける', '{Mengantarkan} kotak kardus besar.', ['とどける', 'ぶつける', 'あずける', 'わける'], 0),
  _q(49, 62, '妹[いもうと]の赤[あか]い洋服[ようふく]を探[さが]す。', '探す', 'さがす', '{Mencari} pakaian merah milik adik perempuan.', ['なおす', 'のこす', 'ほす', 'さがす'], 3),
  _q(50, 62, '彼女[かのじょ]は昨日[きのう]から怒[おこ]っている。', '怒', 'おこ', 'Dia {marah} sejak kemarin.', ['こまって', 'おこって', 'だまって', 'まよって'], 1),

  // Page 63
  _q(51, 63, '緑[みどり]の糸[いと]と白[しろ]い糸[いと]を編[あ]んでいます。', '編んで', 'あんで', 'Saya sedang {merajut} benang hijau dan putih.', ['えらんで', 'むすんで', 'あんで', 'たのんで'], 2),
  _q(52, 63, '強[つよ]い風[かぜ]で木[き]が折[お]れた。', '折れた', 'おれた', 'Pohon itu {patah} karena angin kencang.', ['たおれた', 'おれた', 'ゆれた', 'かれた'], 1),
  _q(53, 63, '弟[おとうと]が妹[いもうと]の布団[ふとん]を干[ほ]した。', '干した', 'ほした', 'Adik laki-laki {menjemur} futon milik adik perempuan.', ['かくした', 'よごした', 'ほした', 'かえした'], 2),
  _q(54, 63, '中島[なかじま]さんが酔[よ]ってしまいました。', '酔って', 'よって', 'Nakajima-san sampai {mabuk}.', ['よって', 'すべって', 'しゃべって', 'あまって'], 0),
  _q(55, 63, '友達[ともだち]に借[か]りていた服[ふく]を渡[わた]す。', '渡す', 'わたす', '{Menyerahkan} pakaian yang saya pinjam kepada teman.', ['かえす', 'ほす', 'わたす', 'よごす'], 2),
  _q(56, 63, '隣[となり]の席[せき]に移[うつ]りましょう。', '移り', 'うつり', 'Mari {pindah} ke kursi sebelah.', ['すわり', 'うつり', 'くばり', 'もどり'], 1),
  _q(57, 63, 'テストの内容[ないよう]を変[か]える。', '変える', 'かえる', '{Mengubah} isi tes.', ['おぼえる', 'くわえる', 'つたえる', 'かえる'], 3),
  _q(58, 63, '黒[くろ]い手箱[てばこ]を拾[ひろ]った。', '拾った', 'ひろった', 'Saya {memungut} kotak kecil berwarna hitam.', ['さわった', 'ひろった', 'まもった', 'かった'], 1),
  _q(59, 63, '携帯電話[けいたいでんわ]を直[なお]す。', '直す', 'なおす', '{Memperbaiki} ponsel.', ['おとす', 'わたす', 'かす', 'なおす'], 3),
  _q(60, 63, '松井[まつい]さん、こっちを向[む]いてください。', '向いて', 'むいて', 'Matsui-san, tolong {menghadap} ke sini.', ['むいて', 'やいて', 'みがいて', 'はいて'], 0),

  // Page 64
  _q(61, 64, '水曜日[すいようび]は面白[おもしろ]いテレビ番組[ばんぐみ]があります。', '面白い', 'おもしろい', 'Pada hari Rabu ada acara TV yang {menarik}.', ['おもい', 'おそろしい', 'おかしい', 'おもしろい'], 3),
  _q(62, 64, '新幹線[しんかんせん]はとても速[はや]い。', '速い', 'はやい', 'Shinkansen sangat {cepat}.', ['たかい', 'やすい', 'あぶない', 'はやい'], 3),
  _q(63, 64, '彼[かれ]とは親[した]しい友達[ともだち]です。', '親しい', 'したしい', 'Dia adalah teman {dekat} saya.', ['あやしい', 'したしい', 'むずかしい', 'なつかしい'], 1),
  _q(64, 64, '寒[さむ]い季節[きせつ]になりました。', '寒い', 'さむい', 'Telah memasuki musim yang {dingin}.', ['すずしい', 'さむい', 'あつい', 'あたたかい'], 1),
  _q(65, 64, '大会[たいかい]に出[で]ることはとても難[むずか]しい。', '難しい', 'むずかしい', 'Mengikuti pertandingan itu sangat {sulit}.', ['たのしい', 'きびしい', 'むずかしい', 'はずかしい'], 2),
  _q(66, 64, 'わたしの兄[あに]はとても優[やさ]しい。', '優しい', 'やさしい', 'Kakak laki-laki saya sangat {baik}.', ['やさしい', 'かわいらしい', 'いそがしい', 'おとなしい'], 0),
  _q(67, 64, '自転車[じてんしゃ]で転[ころ]んで、足[あし]が痛[いた]い。', '痛い', 'いたい', 'Saya jatuh dari sepeda dan kaki saya {sakit}.', ['つらい', 'くさい', 'かゆい', 'いたい'], 3),
  _q(68, 64, '昨日[きのう]買[か]った辞書[じしょ]はとても厚[あつ]い。', '厚い', 'あつい', 'Kamus yang saya beli kemarin sangat {tebal}.', ['うすい', 'あつい', 'ちいさい', 'たかい'], 1),
  _q(69, 64, '今[いま]運[はこ]んでいる荷物[にもつ]は軽[かる]い。', '軽い', 'かるい', 'Barang bawaan yang sedang saya bawa {ringan}.', ['ふとい', 'おもい', 'かるい', 'ほそい'], 2),
  _q(70, 64, '明日[あした]から新[あたら]しい生活[せいかつ]が始[はじ]まる。', '新しい', 'あたらしい', 'Mulai besok, kehidupan {baru} akan dimulai.', ['まずしい', 'さびしい', 'あたらしい', 'くるしい'], 2),

  // Page 65
  _q(71, 65, '寒[さむ]いので、温[あたた]かい飲[の]み物[もの]を飲[の]もう。', '温かい', 'あたたかい', 'Karena dingin, mari minum minuman {hangat}.', ['こまかい', 'あたたかい', 'たかい', 'やわらかい'], 1),
  _q(72, 65, '欲[ほ]しい絵[え]がなかったので、店[みせ]を出[で]た。', '欲しい', 'ほしい', 'Karena tidak ada gambar yang saya {inginkan}, saya keluar dari toko.', ['めずらしい', 'あやしい', 'すばらしい', 'ほしい'], 3),
  _q(73, 65, '正[ただ]しい結果[けっか]が出[で]た。', '正しい', 'ただしい', 'Hasil yang {benar} keluar.', ['ただしい', 'くわしい', 'くやしい', 'かなしい'], 0),
  _q(74, 65, 'この山[やま]は、あの山[やま]よりも低[ひく]いです。', '低い', 'ひくい', 'Gunung ini lebih {rendah} daripada gunung itu.', ['きたない', 'ひろい', 'せまい', 'ひくい'], 3),
  _q(75, 65, '妹[いもうと]が可愛[かわい]くて仕方[しかた]がない。', '可愛くて', 'かわいくて', 'Adik perempuan saya sangat {menggemaskan}.', ['かわいくて', 'こいしくて', 'うらやましくて', 'うつくしくて'], 0),
  _q(76, 65, '彼女[かのじょ]は勉強[べんきょう]熱心[ねっしん]な生徒[せいと]です。', '熱心', 'ねっしん', 'Dia adalah murid yang {tekun} belajar.', ['ねっじん', 'ねっじん', 'ねっしん', 'ねっしん'], 2),
  _q(77, 65, '大事[だいじ]なゆびわをなくしてしまった。', '大事', 'だいじ', 'Saya kehilangan cincin yang {penting}.', ['だいし', 'たいし', 'たいじ', 'だいじ'], 3),
  _q(78, 65, '家[いえ]の近[ちか]くにコンビニがなくて不便[ふべん]だ。', '不便', 'ふべん', 'Tidak ada minimarket dekat rumah, jadi {tidak nyaman}.', ['ふべん', 'ふへん', 'ふうべん', 'ふうへん'], 0),
  _q(79, 65, '昨日[きのう]の試合[しあい]は残念[ざんねん]な結果[けっか]になった。', '残念', 'ざんねん', 'Pertandingan kemarin berakhir dengan hasil yang {mengecewakan}.', ['じゃんねん', 'ざんねん', 'さんねん', 'じゃねん'], 1),
  _q(80, 65, '母[はは]から簡単[かんたん]な料理[りょうり]を教[おし]えてもらいました。', '簡単', 'かんたん', 'Ibu mengajari saya masakan {sederhana}.', ['かんたん', 'かたん', 'かんた', 'かた'], 0),

  // Page 66
  _q(81, 66, '彼女[かのじょ]に正直[しょうじき]な気持[きも]ちを伝[つた]える。', '正直', 'しょうじき', 'Menyampaikan perasaan {jujur} kepada dia.', ['しょうちょく', 'しょちょく', 'しょしき', 'しょうじき'], 3),
  _q(82, 66, '旅行[りょこう]に必要[ひつよう]なものを買[か]いに行[い]きましょう。', '必要', 'ひつよう', 'Mari membeli barang yang {diperlukan} untuk perjalanan.', ['ひつじょう', 'ひつじょ', 'ひつよう', 'ひつよ'], 2),
  _q(83, 66, '先輩[せんぱい]に失礼[しつれい]なことをしてしまった。', '失礼', 'しつれい', 'Saya bersikap {tidak sopan} kepada senior.', ['しつれい', 'しつれい', 'しつれ', 'しつれ'], 0),
  _q(84, 66, '苦手[にがて]な食[た]べ物[もの]はにんじんです。', '苦手', 'にがて', 'Makanan yang {tidak saya sukai} adalah wortel.', ['くるて', 'にがしゅ', 'くるしゅ', 'にがて'], 3),
  _q(85, 66, '自由[じゆう]に文章[ぶんしょう]を書[か]いてみましょう。', '自由', 'じゆう', 'Mari coba menulis kalimat dengan {bebas}.', ['じゆ', 'じゆう', 'しゆ', 'しゅう'], 1),
  _q(86, 66, '不要[ふよう]なものは買[か]わない。', '不要', 'ふよう', 'Jangan membeli barang yang {tidak diperlukan}.', ['ふよ', 'ふりょ', 'ふよう', 'ふりょう'], 2),
  _q(87, 66, '安全[あんぜん]な場所[ばしょ]で遊[あそ]びましょう。', '安全', 'あんぜん', 'Mari bermain di tempat yang {aman}.', ['あぜん', 'あんせい', 'あんせん', 'あんぜん'], 3),
  _q(88, 66, '一人[ひとり]でするには大変[たいへん]な仕事[しごと]でした。', '大変', 'たいへん', 'Itu pekerjaan yang {berat} untuk dikerjakan sendirian.', ['たいべん', 'たいへん', 'だいへん', 'だいべん'], 1),
  _q(89, 66, '今日[きょう]は休[やす]みだったので十分[じゅうぶん]に寝[ね]ることができた。', '十分', 'じゅうぶん', 'Karena hari ini libur, saya bisa tidur {cukup}.', ['じゅうふん', 'じゅふん', 'じゅうぶん', 'じゅぶん'], 2),
  _q(90, 66, '今回[こんかい]の会議[かいぎ]は主要[しゅよう]なメンバーで行[おこな]う。', '主要', 'しゅよう', 'Rapat kali ini dilaksanakan oleh anggota {inti}.', ['しゅよう', 'しゅよ', 'しゅうよう', 'しゅうよ'], 0),
];

Question _q(
  int id,
  int sourcePage,
  String sentence,
  String testedWord,
  String reading,
  String translation,
  List<String> options,
  int answerIndex,
) {
  final sourceNumber = (id - 1) % 10 + 1;
  return Question.reading(
    id: id,
    sourcePage: sourcePage,
    sourceNumber: sourceNumber,
    sentence: sentence,
    testedWord: testedWord,
    reading: reading,
    translation: translation,
    options: options,
    answerIndex: answerIndex,
    explanation: '「$testedWord」 dibaca 「$reading」. Jawaban yang tepat adalah 「${options[answerIndex]}」.',
  );
}
