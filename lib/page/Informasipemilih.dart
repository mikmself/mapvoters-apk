import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowData(),
    );
  }
}

class ShowData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Detail Data',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Transform.rotate(
                    angle: 3.14,
                    child: IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        // Handle exit action
                      },
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                thickness: 2,
                height: 20,
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 160,
                color: Colors.grey[300],
                child: Center(
                  child: Text('FOTO KTP'),
                ),
              ),
              SizedBox(height: 16),
              _buildContainerWithText('NIK', '3302298738928392'),
              _buildContainerWithText('NAMA', 'YUSUF NUR ALAM'),
              _buildContainerWithText('TELEPHONE', '082782324829'),
              _buildContainerWithText('PROVINSI', 'Jawa TENGAH'),
              _buildContainerWithText('KABUPATEN', 'BANYUMAS'),
              _buildContainerWithText('KECAMATAN', 'PURWOKERTO BARAT'),
              _buildContainerWithText('KELURAHAN', 'PASIR KIDUL'),
              _buildContainerWithText('TPS', '08'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainerWithText(String labelText, String value) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[300], // Ubah warna sesuai dengan warna foto KTP
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
