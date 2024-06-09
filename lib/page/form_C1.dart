import 'package:flutter/material.dart';
// import 'package:flutter_application_1/textfield.dart';

class FormC1 extends StatefulWidget {
  const FormC1({super.key});

  @override
  State<FormC1> createState() => _FormC1State();
}

class _FormC1State extends State<FormC1> {
  @override
  Widget build(BuildContext context) {
    TextEditingController jumlahsuaracontroler = TextEditingController();
    TextEditingController uploadbukticontroler = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.height;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Handle menu button
          },
        ),
      ),
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
                'SAKSI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
            Container(
              height: 60,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 138, 160, 144),
                    // borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Text('Jumlah Suara    :    '),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 245, 240, 240),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
            // const SizedBox(height: 10),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Text('Upload Bukti      :    '),
                  ElevatedButton(
                    onPressed: () {
                      // Handle file upload
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      ),
                    backgroundColor: Color.fromARGB(255, 174, 189, 174),
                    shadowColor: Color.fromARGB(255, 22, 17, 17),
                    ),
                    child: const Text('Pilih File', style: TextStyle(
                        fontSize: 14, // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 58, 57, 57),
                      ),),
                  ),                 
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 380,
              color: Colors.grey[100],
              child: const Center(
                child: Text('PREVIEW', 
                style: TextStyle(
                  fontSize: 28, // Adjust the font size as needed
                        // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [ 
                ElevatedButton(
                  onPressed: () {
                  // Handle update
                  },                  
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color.fromARGB(255, 138, 160, 144),
                    shadowColor: Color.fromARGB(255, 22, 17, 17),
                  ),
                  child: const Text('UPDATE',style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,// Adjust the font size as needed
                  color: Color.fromARGB(255, 251, 251, 251),                  
                  ),
                  ),
                ),                
              ],
            ),
          ],
        ), 
        ),
      )
    );
  }
}

