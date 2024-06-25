import 'package:flutter/material.dart';
import 'package:mapvotersapk/component/data/GlobalVariable.dart';
import 'package:mapvotersapk/component/model/DashboardModel.dart';
import 'package:mapvotersapk/component/service/DashboardService.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardService service = DashboardService();
  DashboardModel? dashboard;

  @override
  void initState() {
    super.initState();
    showKoordinatorDetailDialog();
  }

  Future<void> showKoordinatorDetailDialog() async {
    if (loginData != null ) {
      DashboardModel? fetchedDashboard =
          await service.GetDashboardDetail(loginData['userID']);

      if (fetchedDashboard != null) {
        setState(() {
          dashboard = fetchedDashboard;
        });
      } else {
        print("Failed to fetch dashboard details.");
      }
    } else {
      print("Invalid paslonID in loginData.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFFF6F5F2)),
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 381,
                    height: 730,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 2,
                          top: 0,
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 180,
                                    height: 180,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFABB7BD),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 2, color: Color(0xFF848484)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 16,
                                  top: 15,
                                  child: SizedBox(
                                    width: 164,
                                    child: Text(
                                      'Target Suara :',
                                      style: TextStyle(
                                        color: Color(0xFFF6F5F2),
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  top: 63,
                                  child: SizedBox(
                                    width: 159,
                                    child: Text(
                                      dashboard != null
                                          ? dashboard!.targetSuara.toString()
                                          : 'Loading...',
                                      // Example placeholder text
                                      style: TextStyle(
                                        color: Color(0xFFF6F5F2),
                                        fontSize: 40,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 201,
                          top: 0,
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 180,
                                    height: 180,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFABB7BD),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 2, color: Color(0xFF848484)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 16,
                                  top: 15,
                                  child: SizedBox(
                                    width: 149,
                                    child: Text(
                                      'Koordinator :',
                                      style: TextStyle(
                                        color: Color(0xFFF6F5F2),
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 37,
                                  top: 62,
                                  child: SizedBox(
                                    width: 106,
                                    child: Text(
                                      dashboard != null
                                          ? dashboard!.totalKoordinator
                                              .toString()
                                          : 'Loading...',
                                      // Example placeholder text
                                      style: TextStyle(
                                        color: Color(0xFFF6F5F2),
                                        fontSize: 40,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 2,
                          top: 199,
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 180,
                                    height: 180,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFABB7BD),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 2, color: Color(0xFF848484)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 16,
                                  top: 15,
                                  child: SizedBox(
                                    width: 137,
                                    child: Text(
                                      'Total Saksi :',
                                      style: TextStyle(
                                        color: Color(0xFFF6F5F2),
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 23,
                                  top: 62,
                                  child: SizedBox(
                                    width: 134,
                                    child: Text(
                                      dashboard != null
                                          ? dashboard!.totalSaksi.toString()
                                          : 'Loading...',
                                      // Example placeholder text
                                      style: TextStyle(
                                        color: Color(0xFFF6F5F2),
                                        fontSize: 40,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 201,
                          top: 199,
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 180,
                                    height: 180,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFABB7BD),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 2, color: Color(0xFF848484)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 16,
                                  top: 15,
                                  child: SizedBox(
                                    width: 137,
                                    child: Text(
                                      'Peta Suara :',
                                      style: TextStyle(
                                        color: Color(0xFFF6F5F2),
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  top: 62,
                                  child: SizedBox(
                                    width: 159,
                                    child: Text(
                                      dashboard != null
                                          ? dashboard!.totalSuaraPotensial
                                              .toString()
                                          : 'Loading...',
                                      // Example placeholder text
                                      style: TextStyle(
                                        color: Color(0xFFF6F5F2),
                                        fontSize: 40,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 398,
                          child: SizedBox(
                            width: 381,
                            height: 180,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 381,
                                    height: 180,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFABB7BD),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 2, color: Color(0xFF848484)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 21,
                                  top: 15,
                                  child: SizedBox(
                                    width: 289.98,
                                    child: Text(
                                      'Perhitungan Suara Real :',
                                      style: TextStyle(
                                        color: Color(0xFFF6F5F2),
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 21.17,
                                  top: 63,
                                  child: SizedBox(
                                    width: 336.55,
                                    child: Text(
                                      dashboard != null
                                          ? dashboard!.perhitunganSuaraReal
                                              .toString()
                                          : 'Loading...',
                                      // Example placeholder text
                                      style: TextStyle(
                                        color: Color(0xFFF6F5F2),
                                        fontSize: 40,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
