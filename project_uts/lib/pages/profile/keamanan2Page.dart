import 'package:flutter/material.dart';

class Keamanan2Page extends StatefulWidget {
  const Keamanan2Page({super.key});

  @override
  State<Keamanan2Page> createState() => _Keamanan2PageState();
}

class _Keamanan2PageState extends State<Keamanan2Page> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //Ini bagian AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),

      //Ini bagian Isi Halaman
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),

            //Ini bagian Judul Halaman
            const Text(
              'Masukkan password baru',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xff17005c),
              ),
            ),

            const SizedBox(height: 45),

            //Ini bagian Input Password Baru
            TextField(
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                hintText: 'Password Baru',

                //Ini bagian Tombol Lihat Password
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  icon: Icon(
                    passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),

                //Ini bagian Garis Input Password
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 90),

            //Ini bagian Tombol Selesai
            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3164ff),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Selesai',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}