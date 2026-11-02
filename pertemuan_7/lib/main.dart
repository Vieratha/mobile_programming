import 'package:flutter/material.dart';
import 'package:pertemuan_7/workoutpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  int likes = 10;
  bool selected = false;
  bool selected2 = false;
  String message = '';
  int newLikes = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('My Profile'),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),

          body: SingleChildScrollView(
            child: SafeArea(child:
            Container(
              //width: screenWidth * 0.9,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)
                ),

                child: Column(
                  children:  [
                    const Row(
                      children: [
                        Text('My Profile',
                          style: TextStyle
                            (fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text('Edit'),
                      ],
                    ),

                    Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = !selected;
                              });
                            },
                            onDoubleTap: () {
                              setState(() {
                                likes++;
                                newLikes = 1;
                              });
                              Future.delayed(const Duration(seconds: 1), () {
                                setState(() {
                                  newLikes = 0;
                                });
                              });
                            },

                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: selected ? Colors.blue : Colors.transparent,
                                      width: 5
                                  )
                              ),
                              child: Image.network('https://i.pravatar.cc/',
                                errorBuilder: (BuildContext context, Object error,
                                    StackTrace? stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        shape:BoxShape.circle
                                    ),
                                    height: 120,
                                    width: 120,
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 100,),
                                  );
                                },
                                width: 120,
                                height: 120,
                              ),
                            )
                        ),

                        const Positioned(
                          right: 0,
                          bottom: 0,
                          child:Icon(Icons.edit),)
                      ],
                    ),

                    GestureDetector(
                      onLongPress: () {
                        setState(() {
                          selected2 = !selected2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: selected2 ? Colors.blue.shade200 : Colors.transparent,
                                width: 5
                            )
                        ),
                        child: Text('Indra',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ),

                    if (selected2)
                      Text('Profil Dipilih!'),

                    const SizedBox(height: 5),
                    const Text('vietha@gmail.com'),
                    const SizedBox(height: 10),

                    SizedBox (
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5),
                          Text('$likes'),
                          const SizedBox(width: 10),
                          if (newLikes > 0)
                            Text(
                              '+$newLikes',
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const WorkoutPage()),
                                );
                              },

                              child: Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Text(
                                    'Workout',
                                    textAlign: TextAlign.center
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Text(
                                'Log Out',
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ],
                    ),

                    SizedBox(
                      height: 500,
                    ),

                    Container(
                      height: 200,
                      color: Colors.green,
                    )

                  ],
                )
            )
            ),
          )
      ),
    );
  }

}