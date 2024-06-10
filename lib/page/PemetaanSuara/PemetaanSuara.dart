import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PemetaanSuara extends StatefulWidget {
  const PemetaanSuara({super.key, required this.title});
  final String title;

  @override
  State<PemetaanSuara> createState() => _PemetaanSuaraState();
}

class _PemetaanSuaraState extends State<PemetaanSuara> {
  TextEditingController cariprov = TextEditingController();
  String selectedRegion = 'Pemetaan suara provinsi';
  final List<String> regions = [
    'Pemetaan suara kabupaten',
    'Pemetaan suara provinsi',
    'Pemetaan suara kelurahan',
    'Pemetaan suara kecamatan'
  ];

  // Data dummy
  final Map<String, List<String>> dataDummy = {
    'Pemetaan suara provinsi': ['Jawa Barat', 'Jawa Timur', 'Jawa Tengah'],
    'Pemetaan suara kabupaten': [
      'Kabupaten Bandung',
      'Kabupaten Bogor',
      'Kabupaten Bekasi'
    ],
    'Pemetaan suara kecamatan': [
      'Kecamatan Cicendo',
      'Kecamatan Andir',
      'Kecamatan Sukajadi'
    ],
    'Pemetaan suara kelurahan': [
      'Kelurahan Sukamaju',
      'Kelurahan Kebonwaru',
      'Kelurahan Babakan'
    ],
  };

  List<String> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = dataDummy[selectedRegion]!;
    cariprov.addListener(_searchData);
  }

  @override
  void dispose() {
    cariprov.removeListener(_searchData);
    cariprov.dispose();
    super.dispose();
  }

  void _searchData() {
    setState(() {
      filteredData = dataDummy[selectedRegion]!
          .where((item) =>
              item.toLowerCase().contains(cariprov.text.toLowerCase()))
          .toList();
    });
  }

  String getPlaceholderText() {
    switch (selectedRegion) {
      case 'Pemetaan suara kabupaten':
        return 'Kabupaten yang dicari';
      case 'Pemetaan suara provinsi':
        return 'Provinsi yang dicari';
      case 'Pemetaan suara kelurahan':
        return 'Kelurahan yang dicari';
      case 'Pemetaan suara kecamatan':
        return 'Kecamatan yang dicari';
      default:
        return 'Provinsi yang dicari';
    }
  }

  List<Widget> buildDataContainers() {
    return filteredData.map((data) => _buildInfoContainer(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: selectedRegion,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Color(0xFF3E3E3E),
                    ),
                    underline: Container(
                      height: 2,
                      color: Color(0xFF3E3E3E),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRegion = newValue!;
                        filteredData = dataDummy[selectedRegion]!;
                        cariprov.clear();
                      });
                    },
                    items: regions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    iconSize: 30,
                    onPressed: () {
                      // Tambahkan aksi untuk ikon setting di sini
                      _showFilterOptions(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.fromLTRB(11, 10, 11, 0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 179, 179, 179),
                border: Border.all(
                  color: Color.fromARGB(166, 214, 214, 214),
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 124, 124, 124)
                        .withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: cariprov,
                  decoration: InputDecoration(
                    hintText: getPlaceholderText(),
                    hintStyle: GoogleFonts.getFont(
                      'Nunito',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search_sharp),
                      iconSize: 30,
                    ),
                  ),
                  style: GoogleFonts.getFont('Nunito'),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              width: screenWidth * 0.9,
              height: screenHeight * 0.6,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 124, 124, 124)
                    .withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: buildDataContainers(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoContainer(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 1, 9),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 184, 184, 184),
        border: Border.all(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontSize: 20,
                  color: Color.fromARGB(255, 233, 233, 233),
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: 200,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(179, 255, 255, 255),
                borderRadius: BorderRadiusDirectional.circular(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showFilterOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Provinsi'),
              onTap: () {
                _updateDataByRegion('Pemetaan suara provinsi');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Kabupaten'),
              onTap: () {
                _updateDataByRegion('Pemetaan suara kabupaten');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Kecamatan'),
              onTap: () {
                _updateDataByRegion('Pemetaan suara kecamatan');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Kelurahan'),
              onTap: () {
                _updateDataByRegion('Pemetaan suara kelurahan');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

void _updateDataByRegion(String region) {
  setState(() {
    selectedRegion = region;
    filteredData = dataDummy[selectedRegion]!;
    cariprov.clear();
  });
}

}

void main() {
  runApp(MaterialApp(
    title: 'Pemetaan Suara',
    home: PemetaanSuara(title: 'Pemetaan Suara'),
  ));
}