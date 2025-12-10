import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sion_project02/model/user_list.dart';
import 'package:sion_project02/view/home.dart';
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
                  child: SizedBox(
                    width: 150,
                    height: 230,
                    child: Card(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadiusGeometry.circular(
                                    20,
                                  ),
                              child: Image.asset(
                                'images/login.png',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              8.0,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '"${snapshot.data![0].name} 님"',
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                Text('환영합니다'),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(
                              10.0,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                logout(snapshot.data![0]);
                                FocusScope.of(
                                  context,
                                ).unfocus();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.amber,
                                foregroundColor:
                                    Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                        10,
                                      ),
                                ),
                              ),
                              child: Text('LogOut'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: SizedBox(
                    width: 150,
                    height: 200,
                    child: Card(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                              10.0,
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadiusGeometry.circular(
                                    20,
                                  ),
                              child: Image.asset(
                                'images/login.png',
                                width: 100,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              10.0,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                //
                                Get.to(LoginPage());
                                FocusScope.of(
                                  context,
                                ).unfocus();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.amber,
                                foregroundColor:
                                    Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                        10,
                                      ),
                                ),
                              ),
                              child: Text('Login'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  //
  dynamic reloadlogin() async {
    await handlerid.querylogin();
    setState(() {});
  }

  void logout(UserList logout) {
    Get.defaultDialog(
      title: '알림',
      middleText: '${logout.name}님, \n 로그아웃하시겠습니까?',
      backgroundColor: Colors.white,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () async {
            await handlerid.deletelogin(
              logout.id!,
              logout.name,
            );
            reloadlogin();
            Get.back();
            Get.off(Home());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text('LogOut'),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text('취소'),
        ),
      ],
    );
  }

  //
  //
  ///
}
