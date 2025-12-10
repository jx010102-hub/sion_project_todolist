import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sion_project02/model/todo_list.dart';
import 'package:sion_project02/vm/database_handler.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePage();
}

class _UpdatePage extends State<UpdatePage> {
  late DatabaseHandler handler;
  late TextEditingController todotextcontroller; // 할일
  late TextEditingController memocontroller; // memo

  late String dropDownValue; // 드랍다운
  late String imageName; // 드랍다운

  late List<String> items; // 우선순위 이모지

  var value = Get.arguments ?? "__";

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    todotextcontroller = TextEditingController();
    memocontroller = TextEditingController();
    dropDownValue = '기본';

    items = ['기본', '바쁨', '여유있음'];

    todotextcontroller.text = value[1];
    memocontroller.text = value[2];
    imageName = value[3];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpDate Page'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: todotextcontroller,
                  decoration: InputDecoration(
                    labelText: '할일을 입력 하세요',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: memocontroller,
                  decoration: InputDecoration(
                    labelText: '메모를 입력 하세요',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton(
                      value: dropDownValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),

                      onChanged: (value) {
                        //
                        dropDownValue = value!;
                        imageName = 'images/$value.png';
                        setState(() {});
                      },
                    ),
                  ),
                  Image.asset(imageName, width: 100),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  onPressed: () {
                    updateAction();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Text('수정하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  //-------
  Future updateAction() async {
    var updatelist = TodoList(
      id: value[0],
      todo: todotextcontroller.text,
      memo: memocontroller.text,
      priority: imageName,
    );
    int check = await handler.updateAction(updatelist);
    if (check == 0) {
      // error
    } else {
      Get.back();
    }
  }

  //
}
