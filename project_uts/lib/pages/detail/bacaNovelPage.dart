import 'package:flutter/material.dart';

class BacaNovelPage extends StatelessWidget {
  const BacaNovelPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Ini bagian untuk menentukan ukuran layar
    final double screenWidth =
        MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 600;

    //Ini bagian untuk menentukan lebar halaman
    final double contentWidth =
    screenWidth > 900
        ? 900
        : screenWidth - 40;

    return Scaffold(
      backgroundColor: Colors.white,

      //Ini bagian AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        //Ini bagian Tombol Back
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius:
          BorderRadius.circular(20),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        //Ini bagian Judul AppBar
        title: const Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Mode Baca',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Baca Offline',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      //Ini bagian Isi Novel
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: contentWidth,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                isMobile ? 20 : 30,
                15,
                isMobile ? 20 : 30,
                50,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  //Ini bagian Judul Novel
                  const Text(
                    'Whether You Call Me a Guardian Dragon or Not, I’m Going to Sleep',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 12),

                  //Ini bagian Nama Penulis
                  const Center(
                    child: Text(
                      'Penulis: aseutareuteseu (아스타르테스)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Divider(),

                  const SizedBox(height: 20),

                  //Ini bagian Judul Chapter
                  const Text(
                    'Bab 1: Ch.1 Hello. World!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 25),

                  //Ini bagian Isi Novel
                  const Text(
                    'Apa itu Tuhan?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Sampai saat ini, aku tidak pernah memikirkannya secara mendalam, tapi aku tahu pasti bahwa sesuatu yang ada di hadapanku sekarang adalah Tuhan.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Sosok yang aneh, bentuknya menyerupai manusia namun tubuhnya terdiri dari alam semesta.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Jika sosok yang mampu menekan dan mendominasiku hanya dengan melihatnya saja bukan Tuhan, lalu apa lagi?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Oh, kau sudah bangun. Aku sudah menunggu cukup lama.”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Tapi gaya bicaranya terlalu akrab! Seolah-olah dia sedang berbicara dengan teman dekat!',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Ada banyak hal yang ingin kubicarakan, tapi itu tidak akan berarti bagi dirimu yang sekarang. Jadi, aku hanya akan mengatakan hal-hal yang diperlukan saja.”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Tuhan yang tidak memiliki wajah itu tersenyum lebar.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Tidak, mata dan mulutnya tidak terlihat, jadi bagaimana aku bisa tahu kalau Tuhan sedang tersenyum?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Apa-apaan ini? Bagaimana bisa?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Aku telah menciptakan sebuah dunia, maukah kau bereinkarnasi ke sana?”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Reinkarnasi…? Apakah ini genre reinkarnasi oleh Tuhan atau semacamnya?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Bukankah tren itu sudah lewat? Plotnya sudah ketinggalan zaman, tahu?!',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Tentu saja ada pilihan untuk tidak menerima tawaran ini, tapi jika begitu….”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Tuhan menggerakkan tangannya membentuk sebuah persegi, dan persegi itu memancarkan cahaya aneh yang memperlihatkan pemandangan lain.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Tubuh aslimu sudah mati.”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Apa?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Henti jantung mendadak. Henti jantung mendadak akibat infark miokard. Karena terjadi saat kau sedang tidur, kau mati tanpa sempat melakukan apa-apa.”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Aku… mati…?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Padahal aku belum mencapai apa pun, aku baru saja mulai melangkah ke dunia masyarakat…?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Jadi bagaimana? Tawaranku. Apakah kau menerimanya?”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Jika aku sudah mati…. Aku tidak punya pilihan selain menerima tawaran ini.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Sial….',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Ya. Pilihan yang bagus. Aku telah menyiapkan tubuh terbaik untukmu. Aku yakin kau akan menyukainya.”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 28),

                  //Ini bagian Lanjutan Cerita
                  const Text(
                    'Tapi mengapa Tuhan ini memberiku tawaran seperti ini? Mengapa harus aku? Apakah ada tujuan tertentu?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Tujuan? Tidak ada. Aku hanya ingin kau hidup dengan menyenangkan dan bahagia.”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Setelah mengatakan itu, Tuhan berpikir sejenak lalu menambahkan.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Tapi jika aku mengirimmu begitu saja tanpa apa-apa, kau mungkin tidak akan bersemangat…. Baiklah! Aku akan memberimu satu syarat.”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Syarat?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Jika kau berhasil mencapai sesuatu yang memuaskan dirimu sendiri di dunia itu, aku akan mengabulkan satu permintaanmu.”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Permintaan?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Apa pun yang kau inginkan. Aku akan mengabulkan satu saja. Jika kau ingin kembali ke dunia asalmu, aku akan mengabulkannya.”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Mengembalikanku ke dunia asal…?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Namun, penilaiannya akan sangat ketat. Aku hanya akan mengabulkannya jika kau benar-benar merasa puas, dari lubuk hatimu yang terdalam, hingga kau merasa tidak ada yang lebih baik dari ini. Kurasa itu tidak akan mudah.”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Setelah berkata demikian, Tuhan bertepuk tangan dengan pelan, dan tanah di bawah kakiku tiba-tiba runtuh.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '“Nah, kalau begitu, semoga perjalananmu menyenangkan!”',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Seolah terjatuh ke dalam lubang yang dalam, jiwaku mulai mengalir entah ke mana, dan aku kehilangan kesadaran di dalam kegelapan tak berujung yang terpantul di sekitarku.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 30),

                  //Ini bagian Kutipan Sejarawan
                  Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xfff7f7f7),
                      borderRadius:
                      BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: const Text(
                      '[Dewa Pencipta yang membuat dunia ini. Ada banyak pendapat mengenai untuk apa Dewa tak bernama ini menciptakan dunia ini, namun tidak ada fakta yang terungkap. Bahkan Naga Pelindung Kerajaan, yang dikenal sebagai ciptaan pertama sekaligus makhluk cerdas pertama, tidak mengetahui niat tersebut. Faktanya, tidak ada seorang pun di dunia ini yang mengetahui niat Dewa Pencipta. Mungkin, Dewa Pencipta menginginkan sebuah dunia di mana ciptaan-ciptaannya hidup sesuka hati mereka.\n\n— Sejarawan Edward Lochsch]',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.8,
                        fontStyle:
                        FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Aku pernah membaca sebuah kalimat dalam buku yang kubaca dulu.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  //Ini bagian Kutipan
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color:
                          Color(0xff005dff),
                          width: 4,
                        ),
                      ),
                    ),
                    child: const Text(
                      '“Burung berjuang untuk keluar dari telurnya. Telur adalah dunia bagi burung. Siapa pun yang ingin lahir harus menghancurkan satu dunia.”',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        fontStyle:
                        FontStyle.italic,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Sepertinya…. Demian, ya? Ada kalimat lanjutannya setelah itu, tapi karena sekarang bukan hal yang penting, aku akan melewatkannya.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Aku sedang mengalami kalimat itu secara nyata, tanpa metafora apa pun.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Dunia yang mengelilingiku. Aku menyentuh dunia yang sangat kokoh itu dan mendorongnya dengan sekuat tenaga.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Aku yang belum lahir harus menghancurkan dunia ini untuk bisa lahir.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Hmm…. Apakah aku seekor unggas? Burung? Kadal?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Melihat ada anggota tubuh, sepertinya aku bukan ular.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Tuhan itu bilang dia menyiapkan tubuh terbaik…. Masa bukan manusia, malah jadi binatang!',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Di antara makhluk yang lahir dari telur, yang bisa disebut tubuh terbaik mungkin adalah Naga, makhluk legendaris.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Yah, fantasi mungkin terdengar seperti omong kosong, tapi sejak aku berhadapan dengan Tuhan, kenyataan atau ketidaknyataan sudah tidak ada artinya lagi.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Terbaik atau bukan, itu bisa kupastikan setelah aku lahir nanti.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Aku mendorong dinding yang mengelilingiku dengan seluruh kekuatanku.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Setelah berjuang keras, meronta ke sana kemari, dan memutar tubuh di ruang yang sangat sempit, telur yang membungkusku mulai retak sedikit.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Retakan yang sangat tipis. Sebuah garis yang hampir tidak terlihat jika tidak diperhatikan dengan seksama, dan cahaya redup mulai merembes masuk melaluinya.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Itulah awalnya.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Seiring dengan doronganku yang kuat, garis tipis itu perlahan memanjang, terbelah, dan menebal.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Begitulah dunia yang membungkusku hancur dan runtuh.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Bersama dengan cahaya yang menyilaukan dan angin yang dingin, aku menghancurkan dunia di dalam telur dan menghadapi dunia baru.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 22),

                  //Ini bagian Hello World
                  const Center(
                    child: Text(
                      'Hello. World!',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight:
                        FontWeight.bold,
                        color: Color(0xff005dff),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Sapaan untuk dunia baru. Bersamaan dengan itu, dunia yang tadinya terhenti mulai bergerak.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 30),

                  //Ini bagian Kelahiran Naga
                  const Text(
                    'Aku terlahir sebagai naga dengan sisik berwarna perak.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Mungkin karena masih muda, kepalaku cukup besar dan sayap di punggungku cukup kecil. Tapi bagaimanapun, naga tetaplah naga.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Aku memantulkan wajahku pada genangan air di dekatku.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Sosok naga muda dengan sisik perak yang menutupi seluruh tubuhnya…. Terasa seperti kadal bertanduk.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Apa ya. Semacam kadal yang terlihat imut? Perasaan seperti itu?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Rasanya seperti karakter yang akan muncul dalam karya perusahaan animasi yang memiliki tikus paling terkenal di dunia.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Untungnya, meski masih sangat muda, aku tidak merasa kesulitan dalam menggerakkan tubuhku.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Aku bangkit dan mengamati area di sekitarku tempat aku dilahirkan.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Sebuah gua kecil yang kosong. Gua yang tidak memiliki apa pun selain genangan air di sudutnya.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Tidak ada jejak orang tua yang melahirkanku, bahkan suara serangga atau burung pun tidak terdengar.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Ruang yang aneh.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Ya. Dunia yang kuhadapi adalah ruang yang aneh.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Bagaimana mengatakannya, tidak selesai? Hasil karya yang memiliki banyak bagian yang kurang?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Jika ditanya bagian mana yang kurang, aku bisa menyebutkan banyak hal, tapi pertama-tama, pohon-pohonnya kecil.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Pohon terbesar bahkan tidak mencapai setinggi pinggangku. Semua pohon terlihat seperti bibit yang baru saja ditanam.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Selain itu, tidak terdengar suara serangga sedikit pun. Jangankan serangga, suara burung pun tidak ada.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Sejak awal, tidak terasa ada tanda-tanda kehidupan sama sekali.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Apakah dunia seperti ini tidak apa-apa….',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Saat aku berpikir demikian, sesuatu muncul di kanan bawah bidang penglihatanku.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    '✉ Bentuk amplop surat kecil.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Apa ini. Seperti messenger….',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 30),

                  //Ini bagian Pesan dari Dewa
                  Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xfff3f6ff),
                      borderRadius:
                      BorderRadius.circular(8),
                      border: Border.all(
                        color:
                        const Color(0xffdce5ff),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          'GodTalk',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                            color:
                            Color(0xff005dff),
                          ),
                        ),

                        SizedBox(height: 15),

                        Text(
                          'Sepertinya kau berhasil bereinkarnasi dengan selamat!',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'Dunia itu baru saja diciptakan, jadi belum lama. Mungkin belum ada makhluk hidup yang layak di sana. Tapi jangan khawatir!',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'Aku akan memberimu beberapa kemampuan sebagai bonus reinkarnasi.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 15),

                        Text(
                          'Kemampuan pertama adalah kemampuan penciptaan. Kau bisa menciptakan apa pun yang ingin kau buat! Bisa dibilang dunia itu adalah mainanmu.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'Aku akan menanamkan cara penggunaan kemampuannya di dalam kepalamu. Cobalah isi dunia ini dengan makhluk hidup yang kau ciptakan!',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 15),

                        Text(
                          'Namun, untuk menciptakan kehidupan, kau harus tahu banyak hal. Jadi, bonus kedua adalah kemampuan untuk melihat informasi dari dunia lain.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'Internet, ya? Ada hal luar biasa di sana. Tentu saja kau yang berasal dari dunia itu pasti sudah tahu betul. Aku yakin ini akan sangat membantumu.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 15),

                        Text(
                          'Bonus terakhir adalah kemampuan untuk memanipulasi waktu.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'Meskipun umurmu tidak terbatas, jika kau menjalani hari demi hari, aku rasa kau pun akan merasa lelah.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'Menghentikan, mempercepat, atau memutar balik waktu agak berbahaya, jadi aku akan memberimu batasan dalam penggunaannya.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'Di dunia itu, kau bisa menjadi sosok yang maha tahu dan maha kuasa.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 15),

                        Text(
                          'Sebagai informasi, ini adalah messenger yang kubuat untuk para dewa. Namanya GodTalk!',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'Saat ini belum ada yang menggunakannya selain aku dan kau. Mungkin suatu saat nanti jika ada dewa-dewa di dunia ini, mereka akan menggunakannya?',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'Jika ada yang ingin kau tanyakan, tanyalah melalui messenger ini. Aku akan menjawabnya dengan seaman dan seramah mungkin.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Apa-apaan ini.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Pada saat itu, sesuatu yang masif mulai merayap masuk ke dalam kepalaku.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Bonus pertama. Kekuatan yang dimiliki Tuhan. Kekuatan untuk mencipta. Kekuatan untuk membuat kehidupan.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Segala cara penggunaan kekuatan itu memenuhi kepalaku.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Setelah itu, pengetahuan terkait bonus kedua mengalir masuk ke kepalaku, dan aku menggunakan kemampuan itu tanpa ragu.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Begitu kemampuan itu digunakan, sebuah jendela persegi muncul di hadapanku.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Jendela yang memiliki tampilan browser web yang sangat kukenal.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Melihat tampilan mesin pencari paling terkenal dari dunia sebelumnya, aku sampai kehilangan kata-kata.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Hal seperti ini…. Bonus reinkarnasi…?',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 35),

                  const Divider(),

                  const SizedBox(height: 20),

                  //Ini bagian Sumber Novel
                  const Text(
                    'Sumber Novel',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'OpenNovel Web',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 25),

                  //Ini bagian Informasi Offline
                  Container(
                    width: double.infinity,
                    padding:
                    const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color:
                      const Color(0xfff3f6ff),
                      borderRadius:
                      BorderRadius.circular(8),
                      border: Border.all(
                        color:
                        const Color(0xffdce5ff),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Icon(
                          Icons.offline_bolt,
                          color:
                          Color(0xff3164ff),
                          size: 20,
                        ),

                        SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            'Halaman ini merupakan mode baca offline. Teks novel disimpan di dalam aplikasi sehingga tetap dapat dibaca tanpa koneksi internet.',
                            style: TextStyle(
                              fontSize: 11,
                              color:
                              Colors.black54,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}