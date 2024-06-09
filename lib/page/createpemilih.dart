import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/WidgetCollection/textfield.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateData(),
    );
  }
}

class CreateData extends StatefulWidget {
  @override
  _CreateDataState createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _subdistrictController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _tpsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Data',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    SizedBox(height: 8), // Mengurangi jarak di sini
                    Container(
                      width: double.infinity,
                      height: 160,
                      color: Colors.grey[300],
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle KTP upload
                          },
                          child: const Text('PILIH FOTO KTP'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildTextField(_nameController, 'NAMA'),
                    _buildTextField(_nikController, 'NIK'),
                    _buildTextField(_telephoneController, 'TELEPHONE'),
                    _buildTextField(_provinceController, 'PROVINSI'),
                    _buildTextField(_districtController, 'KABUPATEN'),
                    _buildTextField(_subdistrictController, 'KECAMATAN'),
                    _buildTextField(_villageController, 'KELURAHAN'),
                    _buildTextField(_tpsController, 'TPS'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Kembali'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle the form submission
                        print('Form submitted');
                      }
                    },
                    child: Text('Tambah'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return textfield(
      hinttext: labelText,
      controllerUse: controller,
      warna: Color.fromARGB(50, 74, 86, 70),
      L: 5,
      R: 5,
      T: 10,
      B: 10,
      tinggi: 50,
      lebar: 350,
      fontsize: 20,
    );
  }
}
