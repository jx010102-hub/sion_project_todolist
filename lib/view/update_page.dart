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
    dropDownValue = '보통';

    items = ['보통', '바쁨', '여유있음'];

    todotextcontroller.text = value[1];
    memocontroller.text = value[2];
    imageName = value[3];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('할일 수정')),
      body: Center(
        child: Column(
          children: [
            Text('ToDay'),
            TextField(
              controller: todotextcontroller,
              decoration: InputDecoration(
                labelText: '할일을 수정 하세요',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            Text('Memo'),
            TextField(
              controller: memocontroller,
              decoration: InputDecoration(
                labelText: '메모를 수정 하세요',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            Text('state'),
            DropdownButton(
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
                imageName = 'images/$value.jpg';
                setState(() {});
              },
            ),
            Image.asset(imageName, width: 100),

            ElevatedButton(
              onPressed: () async {
                await updateAction();
              },
              child: Text('수정하기'),
            ),
          ],
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
