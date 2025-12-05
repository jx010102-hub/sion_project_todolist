import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sion_project02/view/update_page.dart';
import 'package:sion_project02/vm/database_handler.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late DatabaseHandler handler;
  bool isChecked = false;

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
        future: handler.querytodo(),
        builder: (context, snapshot) {
          return snapshot.hasData &&
                  snapshot.data!.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: BehindMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Delete',
                            onPressed: (context) async {
                              await handler.deletelist(
                                snapshot.data![index].id!,
                                snapshot.data![index].todo,
                                snapshot.data![index].memo,
                                snapshot
                                    .data![index]
                                    .priority,
                              );
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () => Get.to(
                          UpdatePage(),
                          arguments: [
                            snapshot.data![index].id!,
                            snapshot.data![index].todo,
                            snapshot.data![index].memo,
                            snapshot.data![index].priority,
                          ],
                        )!.then((vlue) => reloadData()),

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
                                    '${snapshot.data![index].todo}       ㅣ ${snapshot.data![index].memo}',
                                  ),
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      isChecked =
                                          value ?? false;
                                      setState(() {});
                                    },
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
              : Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Image.asset('images/pencil.png'),
                      Text('할 일을 기록하세요'),
                    ],
                  ),
                );
        },
      ),
    );
  }

  //
  //----------
  reloadData() {
    handler.querytodo();
    setState(() {});
  }

  //
}
