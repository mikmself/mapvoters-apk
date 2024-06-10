import 'package:flutter/material.dart';
// import 'package:flutter_application_1/textfield.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 243, 246, 248),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // leading: IconButton(
      //   //   icon: const Icon(Icons.menu),
      //   //   onPressed: () {
      //   //   },
      //   // ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),       
        child: Container(
          decoration: BoxDecoration(
            color:Color.fromARGB(255, 162, 176, 168),
            borderRadius: BorderRadius.circular(10),
          ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                  // arah panah item
                  },
                ),
              const Text(
                'FORM C1',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
            Container(
              height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 138, 160, 144),
                    // borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Text('Provinsi              :    '),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 245, 240, 240),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
            ),
            Container(
              height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 202, 211, 204),
                    // Color.fromARGB(255, 172, 70, 70)rderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Text('Kabupaten         :    '),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 157, 173, 163),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
            ),
            Container(
              height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 138, 160, 144),
                    // borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Text('Kecamatan        :    '),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 245, 240, 240),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
            ),
            Container(
              height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 202, 211, 204),
                    // borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Text('Kelurahan          :    '),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 157, 173, 163),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
            ),
            Container(
              height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 138, 160, 144),
                    // borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Text('TPS                    :    '),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 245, 240, 240),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
            ),
            Container(
              height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 202, 211, 204),
                    // borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Text('Saksi                  :    '),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 157, 173, 163),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
            ),
            Container(
              height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 138, 160, 144),
                    // borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Text('Jumlah Suara   :    '),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 245, 240, 240),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
              width: 200,
              height: 300,
              color: Colors.grey[100],
              child: const Center(
                child: Text('PREVIEW', 
                style: TextStyle(
                  fontSize: 20,
                  ),
                ),
              ),
            ),
            ),
          ],
        ), 
        ),
      )
    );
  }
}