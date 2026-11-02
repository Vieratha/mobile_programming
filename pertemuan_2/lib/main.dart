import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
          title: Center(child: Text('My Profile',
              style: TextStyle(color: Colors.white),)),
            backgroundColor: Colors.blue,
        ),
        body: Container(
          height: 320,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade100,
              borderRadius: BorderRadius.circular(25),
            ),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle
                ),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const Text('Indra',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                ),
              ),
              const Text('vietha@gmail.com',
                style: TextStyle(
                    color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),
              Divider(
                height: 15,
                color: Colors.black,
                thickness: 1,
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 135,
                    height: 35,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              size: 20,
                              color: Colors.white,
                            ),
                            const Text('Edit Profile',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    height: 35,
                    child: ElevatedButton(
                          onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white
                        ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.logout,
                                size: 20,
                                color: Colors.white,
                              ),
                              const Text('Logout',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          )
                        ),
                    )
                ],
              )
              ],
          )
        ),
      ),
    );
  }

}