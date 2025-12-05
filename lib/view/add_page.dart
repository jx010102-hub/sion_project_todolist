import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sion_project02/model/todo_list.dart';
import 'package:sion_project02/view/home.dart';
import 'package:sion_project02/vm/database_handler.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late DatabaseHandler handler;
  late TextEditingController todotextcontroller; // 할일
  late TextEditingController memocontroller; // memo

  late String dropDownValue; // 드랍다운
  late String imageName; // 드랍다운

  late List<String> items; // 우선순위 이모지

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    todotextcontroller = TextEditingController();
    memocontroller = TextEditingController();
    dropDownValue = '보통';
    imageName = 'images/보통.jpg';

    items = ['보통', '바쁨', '여유있음'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('할일 추가')),
      body: Center(
        child: Column(
          children: [
            Text('ToDay'),
            TextField(
              controller: todotextcontroller,
              decoration: InputDecoration(
                labelText: '할일을 입력 하세요',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            Text('Memo'),
            TextField(
              controller: memocontroller,
              decoration: InputDecoration(
                labelText: '메모를 입력 하세요',
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
            Image.asset(imageName, width: 200),

            ElevatedButton(
              onPressed: () => insertAction(),
              child: Text('추가하기'),
            ),
          ],
        ),
      ),
    );
  }

  //
  //-------function
  Future insertAction() async {
    // imageName = 'images/$imageName.jpg';

    var insertlist = TodoList(
      todo: todotextcontroller.text,
      priority: imageName,
      memo: memocontroller.text,
    );
    int check = await handler.insertlist(insertlist);
    if (check == 0) {
      // error
    } else {
      Get.to(Home());
    }
  }

  //
  //
}
