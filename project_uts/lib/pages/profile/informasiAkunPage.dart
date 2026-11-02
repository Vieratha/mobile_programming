import 'package:flutter/material.dart';

class InformasiAkunPage extends StatefulWidget {
  final String namaAwal;
  final String emailAwal;
  final String nomorHandphoneAwal;

  const InformasiAkunPage({
    super.key,
    required this.namaAwal,
    required this.emailAwal,
    required this.nomorHandphoneAwal,
  });

  @override
  State<InformasiAkunPage> createState() => _InformasiAkunPageState();
}

class _InformasiAkunPageState extends State<InformasiAkunPage> {
  late String nama;
  late String email;
  late String nomorHandphone;

  @override
  void initState() {
    super.initState();

    nama = widget.namaAwal;
    email = widget.emailAwal;
    nomorHandphone = widget.nomorHandphoneAwal;
  }

  //Ini bagian Mengembalikan Data
  void simpanData() {
    Navigator.pop(
      context,
      {
        'nama': nama,
        'email': email,
        'nomorHandphone': nomorHandphone,
      },
    );
  }

  //Ini bagian Edit Nama
  void editNama() {
    TextEditingController controller =
    TextEditingController(text: nama);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Nama Lengkap'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    nama = controller.text;
                  });
                }

                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  //Ini bagian Edit Email
  void editEmail() {
    TextEditingController controller =
    TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Email'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    email = controller.text;
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  //Ini bagian Edit Nomor Handphone
  void editNomorHandphone() {
    TextEditingController controller =
    TextEditingController(text: nomorHandphone);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nomor Handphone'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Nomor Handphone',
              hintText: 'Masukkan nomor handphone',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  nomorHandphone = controller.text;
                });

                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          onPressed: simpanData,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Informasi Akun',
          style: TextStyle(
            color: Color(0xff17005c),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            //Ini bagian Foto Profil
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),
            //Ini bagian Nama Profil
            Text(
              nama,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),
            //Ini bagian Judul Edit Profil
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Edit Profil',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),
            //Ini bagian Email
            _AccountItem(
              title: 'Email',
              value: email,
              onTap: editEmail,
            ),

            //Ini bagian Nama Lengkap
            _AccountItem(
              title: 'Nama Lengkap',
              value: nama,
              onTap: editNama,
            ),

            //Ini bagian Nomor Handphone
            _AccountItem(
              title: 'Tambahkan Nomor Handphone',
              value: nomorHandphone,
              onTap: editNomorHandphone,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}

//Ini bagian Item Informasi Akun
class _AccountItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  final bool isLast;

  const _AccountItem({
    required this.title,
    required this.value,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: Border(
            left: const BorderSide(
              color: Colors.black12,
            ),
            right: const BorderSide(
              color: Colors.black12,
            ),
            top: const BorderSide(
              color: Colors.black12,
            ),
            bottom: isLast
                ? const BorderSide(
              color: Colors.black12,
            )
                : BorderSide.none,
          ),
          borderRadius: BorderRadius.vertical(
            top: title == 'Email'
                ? const Radius.circular(8)
                : Radius.zero,
            bottom: isLast
                ? const Radius.circular(8)
                : Radius.zero,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    value.isEmpty
                        ? 'Belum ditambahkan'
                        : value,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.edit_outlined,
              color: Colors.grey,
              size: 27,
            ),
          ],
        ),
      ),
    );
  }
}