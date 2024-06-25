import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/data/ListData.dart';
import 'package:mapvotersapk/page/PemetaanC1/C1Controller.dart';
import 'package:mapvotersapk/page/Pemilih/Pemilih.dart';
import 'package:mapvotersapk/page/Profile.dart';
import 'package:mapvotersapk/page/Saksi/saksi.dart';
import 'package:mapvotersapk/page/Setting.dart';
import 'package:mapvotersapk/page/Koordinator/Koordinator.dart';
import 'package:mapvotersapk/page/dashboard.dart';
import 'package:sidebarx/sidebarx.dart';

void main() {
  runApp(const SidebarApp());
}

class SidebarApp extends StatefulWidget {
  const SidebarApp({Key? key}) : super(key: key);

  @override
  _SidebarAppState createState() => _SidebarAppState();
}

class _SidebarAppState extends State<SidebarApp> {
  int _selectedIndex = 0;
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  final List<Widget> _widgetOptions = <Widget>[
    Dashboard(title: 'Dashboard'),
    Koordinator(title: 'Koordinator'),
    Saksi(labeltext: "Search by nama", judul: "Saksi", list: saksiList, title: "Saksi"),
    Pemilih(title: 'Pemilih',),
    PemetaanSuara(title: 'Pemetaan Suara'),
    PemetaanSuaraC1(labeltext: 'cari', title: 'Pemetaan C1'),
    ProfilePage(title: "Profile Paslon"),
    SettingPage(title: 'Pengaturan'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.selectIndex(index);
    });

    if (_key.currentState?.isDrawerOpen ?? false) {
      Navigator.of(_key.currentContext!).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SidebarX Example',
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: canvasColor,
                    title: Text(
                      _widgetOptions[_selectedIndex] is Dashboard ||
                              _widgetOptions[_selectedIndex] is Koordinator ||
                              _widgetOptions[_selectedIndex] is Saksi ||
                              _widgetOptions[_selectedIndex] is Pemilih ||
                              _widgetOptions[_selectedIndex] is PemetaanSuaraC1 ||
                              _widgetOptions[_selectedIndex] is ProfilePage ||
                              _widgetOptions[_selectedIndex] is SettingPage
                          ? (_widgetOptions[_selectedIndex] as dynamic).title
                          : 'Map Voters',
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  )
                : null,
            drawer: isSmallScreen
                ? Sidebar(controller: _controller, onItemTapped: _onItemTapped)
                : null,
            body: Row(
              children: [
                if (!isSmallScreen)
                  Sidebar(controller: _controller, onItemTapped: _onItemTapped),
                Expanded(
                  child: _widgetOptions[_selectedIndex],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key? key,
    required this.controller,
    required this.onItemTapped,
  }) : super(key: key);

  final SidebarXController controller;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 40),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 30,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 35,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 300,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return const Padding(padding: EdgeInsets.only(top: 50));
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'DASHBOARD',
          onTap: () {
            onItemTapped(0);
          },
        ),
        SidebarXItem(
          icon: Icons.account_tree,
          label: 'KOORDINATOR',
          onTap: () {
            onItemTapped(1);
          },
        ),
        SidebarXItem(
          icon: Icons.account_box,
          label: 'SAKSI',
          onTap: () {
            onItemTapped(2);
          },
        ),
        SidebarXItem(
          icon: Icons.people,
          label: 'CALON PEMILIH',
          onTap: () {
            onItemTapped(3);
          },
        ),
        SidebarXItem(
          icon: Icons.map,
          label: 'PETA SUARA',
          onTap: () {
            onItemTapped(4);
          },
        ),
        SidebarXItem(
          icon: Icons.photo,
          label: 'C1 SUARA',
          onTap: () {
            onItemTapped(5);
          },
        ),
        SidebarXItem(
          icon: Icons.people_alt_sharp,
          label: 'PROFILE',
          onTap: () {
            onItemTapped(6);
          },
        ),
        SidebarXItem(
          icon: Icons.settings,
          label: 'PENGATURAN',
          onTap: () {
            onItemTapped(7);
          },
        ),
      ],
    );
  }
}

const canvasColor = Color(0xFF00A6A6);
const scaffoldBackgroundColor = Color(0xFF70CED4);
const accentCanvasColor = Color(0xFF27A18B);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
