import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model.dart';

class PemetaanSuara extends StatefulWidget {
  const PemetaanSuara({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<PemetaanSuara> createState() => _PemetaanSuaraState();
}

class _PemetaanSuaraState extends State<PemetaanSuara> {
  TextEditingController cariprov = TextEditingController();
  String selectedRegion = 'Pemetaan suara provinsi';
  String? selectedParent;
  final List<String> regions = [
    'Pemetaan suara kabupaten',
    'Pemetaan suara provinsi',
    'Pemetaan suara kelurahan',
    'Pemetaan suara kecamatan'
  ];

  final Map<String, List<String>> dataMap = {
    'Pemetaan suara provinsi': provinsi.map((p) => p.provinsi!).toList(),
    'Pemetaan suara kabupaten': kabupaten.map((k) => k.kabupaten!).toList(),
    'Pemetaan suara kecamatan': kecamatan.map((k) => k.kecamatan!).toList(),
    'Pemetaan suara kelurahan': kelurahan.map((k) => k.kelurahan!).toList(),
  };

  final Map<String, int> suaraMap = {
    for (var p in provinsi) p.provinsi!: p.suara!,
    for (var k in kabupaten) k.kabupaten!: k.suara!,
    for (var k in kecamatan) k.kecamatan!: k.suara!,
    for (var k in kelurahan) k.kelurahan!: k.suara!,
  };

  List<String> filteredData = [];
  Map<String, String> parentRegionMap = {};

  @override
  void initState() {
    super.initState();
    filteredData = dataMap[selectedRegion]!;
    cariprov.addListener(_searchData);

    // Populate parentRegionMap
    kabupaten.forEach((k) {
      parentRegionMap[k.kabupaten!] = k.provinsi!;
    });
    kecamatan.forEach((k) {
      parentRegionMap[k.kecamatan!] = k.kabupaten!;
    });
    kelurahan.forEach((k) {
      parentRegionMap[k.kelurahan!] = k.kecamatan!;
    });
  }

  @override
  void dispose() {
    cariprov.removeListener(_searchData);
    cariprov.dispose();
    super.dispose();
  }

  void _searchData() {
    setState(() {
      filteredData = dataMap[selectedRegion]!
          .where((item) =>
              item.toLowerCase().contains(cariprov.text.toLowerCase()) &&
              (selectedParent == null ||
                  parentRegionMap[item] == selectedParent))
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
    return filteredData
        .map((data) => GestureDetector(
              onTap: () => _handleDoubleTap(data),
              child: _buildInfoContainer(data, suaraMap[data]!),
            ))
        .toList();
  }

  void _handleDoubleTap(String data) {
    setState(() {
      if (selectedRegion == 'Pemetaan suara provinsi') {
        selectedRegion = 'Pemetaan suara kabupaten';
        selectedParent = data;
      } else if (selectedRegion == 'Pemetaan suara kabupaten') {
        selectedRegion = 'Pemetaan suara kecamatan';
        selectedParent = data;
      } else if (selectedRegion == 'Pemetaan suara kecamatan') {
        selectedRegion = 'Pemetaan suara kelurahan';
        selectedParent = data;
      }
      filteredData = dataMap[selectedRegion]!
          .where((item) =>
              item.toLowerCase().contains(cariprov.text.toLowerCase()) &&
              (selectedParent == null ||
                  parentRegionMap[item] == selectedParent))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     border: Border.all(
                //       color: const Color.fromARGB(255, 48, 48, 48),
                //     ),
                //   ),
                //   margin: EdgeInsets.fromLTRB(2, 10, 2, 0),
                //   padding: EdgeInsets.fromLTRB(10, 0, 12, 0),
                //   child: DropdownButton<String>(
                //     value: selectedRegion,
                //     icon: Icon(Icons.ads_click_rounded),
                //     iconSize: 20,
                //     elevation: 16,
                //     style: GoogleFonts.getFont(
                //       'Nunito',
                //       fontWeight: FontWeight.w900,
                //       fontSize: 20,
                //       color: Color(0xFF3E3E3E),
                //     ),
                //     borderRadius: BorderRadius.circular(8),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         selectedRegion = newValue!;
                //         filteredData = dataMap[selectedRegion]!;
                //         selectedParent = null;
                //         cariprov.clear();
                //       });
                //     },
                //     items:
                //         regions.map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //   ),
                // ),
              ],
            ),
          ),
          if (selectedRegion != 'Pemetaan suara provinsi')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.fromLTRB(15, 0, 5, 0),
                child: DropdownButton<String>(
                  value: selectedParent,
                  hint: Text(
                    'KAWASAN WILAYAH',
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      color: Color(0xFF3E3E3E),
                    ),
                  ),
                  items: _getParentRegionItems()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: Color(0xFF3E3E3E),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedParent = newValue;
                      _searchData();
                    });
                  },
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.fromLTRB(11, 5, 11, 0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 128, 221, 206),
                border: Border.all(
                  color: Color.fromARGB(166, 214, 214, 214),
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 63, 63, 63).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  controller: cariprov,
                  decoration: InputDecoration(
                    hintText: getPlaceholderText(),
                    hintStyle: GoogleFonts.getFont(
                      'Nunito',
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search_sharp),
                      iconSize: 20,
                    ),
                  ),
                  style: GoogleFonts.getFont('Nunito'),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildDataContainers(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getParentRegionItems() {
    if (selectedRegion == 'Pemetaan suara kabupaten') {
      return provinsi.map((p) => p.provinsi!).toList();
    } else if (selectedRegion == 'Pemetaan suara kecamatan') {
      return kabupaten.map((k) => k.kabupaten!).toList();
    } else if (selectedRegion == 'Pemetaan suara kelurahan') {
      return kecamatan.map((k) => k.kecamatan!).toList();
    }
    return [];
  }

  Widget _buildInfoContainer(String text, int suara) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: GoogleFonts.getFont(
                    'Nunito',
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              
              Container(
                width: 80,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 189, 247, 247),
                  borderRadius: BorderRadiusDirectional.circular(5),
                ),
                child: Center(
                  child: Text(
                    suara.toString(),
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

