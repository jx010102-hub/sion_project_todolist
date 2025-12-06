import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sion_project02/model/user_list.dart';
import 'package:sion_project02/view/home.dart';
import 'package:sion_project02/vm/database_id_handler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Property
  late TextEditingController idController; //id
  late TextEditingController pwContriller; //password
  late DatabaseIdHandler handler;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwContriller = TextEditingController();
    handler = DatabaseIdHandler();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('LOG IN'),
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Image.asset(
                  'images/login.png',
                  width: 130,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID를 입력하세요',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: pwContriller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PassWord를 입력하세요',
                  ),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () => insertAction(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                ),
                child: Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //

  Future insertAction() async {
    if (idController.text.trim().isEmpty ||
        pwContriller.text.trim().isEmpty) {
      return buttonSnack();
    }

    if (idController.text.trim() == 'sion' &&
        pwContriller.text.trim() == '1234') {
      var insertid = UserList(name: idController.text);
      int check = await handler.insertlogin(insertid);
      if (check > 0) {
        buttonDialog();
        Get.to(Home(), arguments: idController.text);
        idController.clear();
        pwContriller.clear();
      } else {
        return buttonSnack2();
      }
    }

    setState(() {});
  }

  dynamic buttonSnack() {
    Get.snackbar(
      "다시해",
      '아이디와 패스워드를 입력하세용.',
      snackPosition: SnackPosition.BOTTOM, // Top, Buttom
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    setState(() {});
  }

  dynamic buttonDialog() {
    Get.defaultDialog(
      title: 'Welcom to the sion World',
      titleStyle: TextStyle(
        fontSize: 15,
        color: Colors.blue,
      ),
      middleText: '완벽해요',
      backgroundColor: Colors.white,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.to(Home(), arguments: idController.text);
            idController.clear();
            pwContriller.clear();
          },
          child: Text('OK'),
        ),
      ],
    );
    setState(() {});
  }

  buttonSnack2() {
    Get.snackbar(
      "땡~~~",
      'ID와 비번이 틀렸ㅇㅇ.',
      snackPosition: SnackPosition.BOTTOM, // Top, Buttom
      duration: Duration(seconds: 2),
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
    setState(() {});
  }

  //
}
