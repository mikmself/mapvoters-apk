import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/PaslonModel.dart';
import 'package:mapvotersapk/component/service/PaslonService.dart';

class FotoPage extends StatefulWidget {
  final VoidCallback onBack;
  const FotoPage({Key? key, required this.title, required this.onBack})
      : super(key: key);
  final String title;

  @override
  State<FotoPage> createState() => _FotoPageState();
}

class _FotoPageState extends State<FotoPage> {
  final PaslonService service = PaslonService();
  PaslonModel? paslon;

  File? _imageFile;

  @override
  void initState() {
    super.initState();
  }

  Future<void> updatePaslon() async {
    if (paslon == null) {
      return;
    }

    String url = BASE_URL + '/paslon/${loginData['userID']}';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      if (_imageFile != null) {
        var fileStream =
            http.ByteStream(Stream.castFrom(_imageFile!.openRead()));
        var length = await _imageFile!.length();
        var multipartFile = http.MultipartFile('foto', fileStream, length,
            filename: _imageFile!.path.split('/').last);
        request.files.add(multipartFile);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Paslon updated successfully'),
          ),
        );
      } else {
        print('Failed to update paslon. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating paslon: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: SizedBox(
                  height: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 10),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 80),
                            Text(
                              "FOTO :",
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                letterSpacing: 1,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black12,
                                fixedSize: const Size(140, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                _pickAnyFile();
                              },
                              child: Text(
                                "PILIH FILE",
                                style: GoogleFonts.getFont(
                                  'Nunito',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                  letterSpacing: 0.5,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      _imageFile != null
                          ? wadahfoto(
                              foto: _imageFile!,
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: 140,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  image: paslon != null && paslon!.foto != null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                            BASE_URL.replaceFirst(
                                                '/api', '/${paslon!.foto!}'),
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  border: Border.all(),
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: paslon != null && paslon!.foto == null
                                    ? Center(child: Text('No Image Available'))
                                    : null,
                              ),
                            ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      updatePaslon();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: const Size(200, 50),
                    ),
                    child: Text(
                      "Update Profile",
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                        fontSize: 18,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onBack();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: const Size(200, 50),
                    ),
                    child: Text(
                      "Update Profile",
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                        fontSize: 18,
                        color: const Color.fromARGB(255, 255, 255, 255),
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

  Future<void> _pickAnyFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.first.path!);
      setState(() {
        _imageFile = file;
      });
    } else {
      setState(() {
        _imageFile = null;
      });
    }
  }
}

void _showImageDialog(BuildContext context, File imageFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    },
  );
}

class wadahfoto extends StatelessWidget {
  final File foto;

  const wadahfoto({
    required this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImageDialog(context, foto);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: 140,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(image: FileImage(foto), fit: BoxFit.cover),
            border: Border.all(),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
