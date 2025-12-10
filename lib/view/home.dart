import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sion_project02/view/first_page.dart';
import 'package:sion_project02/view/four_page.dart';
import 'package:sion_project02/view/login_page.dart';
import 'package:sion_project02/view/second_page.dart';
import 'package:sion_project02/view/add_page.dart';
import 'package:sion_project02/vm/database_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  late DatabaseHandler handler;
  late TabController controller;
  late TextEditingController textcontroller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: 1,
    );
    textcontroller = TextEditingController();
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODOLIST'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(
          255,
          236,
          182,
          20,
        ),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.menu),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                //
                Get.to(LoginPage());
              },
              icon: Icon(Icons.login_rounded),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: controller,
        children: [FirstPage(), SecondPage(), FourPage()],
      ),
      bottomNavigationBar: Container(
        color: Colors.white, //바컨테이너의 색깔
        height: 80, //바높이
        child: TabBar(
          controller: controller, //탭바뷰와 공유
          labelColor: Colors.blueGrey,
          indicatorColor: Colors.amber, //밑에인디케이터색깔
          indicatorWeight: 3,
          tabs: [
            Tab(icon: Icon(Icons.delete), text: "기록"),
            Tab(icon: Icon(Icons.edit), text: "작업"),
            Tab(
              icon: Icon(Icons.home_rounded),
              text: "마이홈",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //그림자있는 버튼이 스크롤 내려도 아래 있고 싶을때
        onPressed: () {
          //
          Get.to(AddPage());
        },
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,

        child: Icon(Icons.add),
      ),
    );
  }

  //
  //
  //----------function -----
}


  //

