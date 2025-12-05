import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sion_project02/model/todo_list.dart';
import 'package:sion_project02/view/home.dart';
import 'package:sion_project02/vm/database_handler.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    reloadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: handler.querytodo2(),
        builder: (context, snapshot) {
          return snapshot.hasData &&
                  snapshot.data!.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    //
                    return GestureDetector(
                      onTap: () =>
                          recovery(snapshot.data![index]),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: BehindMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'Delete',
                              onPressed: (context) async {
                                await handler.deletelist2(
                                  snapshot.data![index].id!,
                                );

                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        child: Card(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(
                                            50,
                                          ),
                                      child: Image.asset(
                                        snapshot
                                            .data![index]
                                            .priority,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot
                                        .data![index]
                                        .todo,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text('깔끔한 녀석'));
        },
      ),
    );
  } //

  //

  void reloadData() {
    handler.querytodo2();
    setState(() {});
  }

  void recovery(TodoList data) {
    Get.defaultDialog(
      title: '알림창',
      middleText: '복구하시겠습니까?',
      backgroundColor: Colors.white,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () async {
            await handler.insertlist(data);
            await handler.deletelist2(data.id!);
            reloadData();
            Get.back();
            Get.off(Home());
          },
          child: Text('복구하기'),
        ),
      ],
    );
  }
}

  //
  //
