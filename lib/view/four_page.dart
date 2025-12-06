import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sion_project02/view/login_page.dart';
import 'package:sion_project02/vm/database_id_handler.dart';

class FourPage extends StatefulWidget {
  const FourPage({super.key});

  @override
  State<FourPage> createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  late DatabaseIdHandler handlerid;
  late String userid;
  late bool button2Visible;

  @override
  void initState() {
    super.initState();
    button2Visible = false;
    handlerid = DatabaseIdHandler();
    reloadlogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: handlerid.querylogin(),
        builder: (context, snapshot) {
          return snapshot.hasData &&
                  snapshot.data!.isNotEmpty
              ? Center(
                  child: Column(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadiusGeometry.circular(
                                          50,
                                        ),
                                    child: Image.asset(
                                      'images/login.png',
                                    ),
                                  ),
                                ),
                                Text(
                                  '${snapshot.data![0].name} 님 환영합니다',
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    //
                                    Get.to(LoginPage());
                                  },
                                  child: Text('LogOut'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Card(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(60),
                          child: Image.asset(
                            'images/login.png',
                          ),
                        ),
                      ),
                      Text(
                        '로그인 해주세요 🙂',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            Get.to(LoginPage()),
                        child: Text('Log In'),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  //
  reloadlogin() async {
    var user = await handlerid.querylogin();
    setState(() {});
  }

  ///
}
