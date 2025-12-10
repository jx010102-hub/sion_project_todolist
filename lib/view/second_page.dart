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
  List<bool> isChecked = [];

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    reloadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
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
                                  snapshot
                                      .data![index]
                                      .todo,
                                  snapshot
                                      .data![index]
                                      .memo,
                                  snapshot
                                      .data![index]
                                      .priority,
                                  snapshot
                                          .data![index]
                                          .complete ??
                                      false,
                                ); // complete 값 주기
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
                              snapshot
                                  .data![index]
                                  .priority,
                              snapshot
                                  .data![index]
                                  .complete,
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
                                            BorderRadius.circular(
                                              50,
                                            ),
                                        child: Image.asset(
                                          snapshot
                                              .data![index]
                                              .priority,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      // Text가 길어져도 Checkbox 안 밀리도록
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                        children: [
                                          Text(
                                            snapshot
                                                .data![index]
                                                .todo,
                                            style: TextStyle(
                                              fontWeight:
                                                  FontWeight
                                                      .bold,
                                              decoration:
                                                  isChecked[index]
                                                  ? TextDecoration
                                                        .lineThrough
                                                  : TextDecoration
                                                        .none,
                                            ),
                                          ),
                                          Text(
                                            snapshot
                                                .data![index]
                                                .memo,
                                            style: TextStyle(
                                              color:
                                                  isChecked[index]
                                                  ? Colors
                                                        .grey
                                                  : Colors
                                                        .blueGrey,
                                              decoration:
                                                  isChecked[index]
                                                  ? TextDecoration
                                                        .lineThrough
                                                  : TextDecoration
                                                        .none,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Checkbox(
                                      value:
                                          isChecked[index],
                                      onChanged: (value) async {
                                        isChecked[index] =
                                            value!;
                                        await handler
                                            .updateComplete(
                                              snapshot
                                                  .data![index]
                                                  .id!,
                                              value,
                                            );
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
                          MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'images/second02.png',
                          width: 330,
                          height: 600,
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  //
  //----------
  reloadData() async {
    var data = await handler.querytodo();
    isChecked = data.map((e) => e.complete == 1).toList();
    setState(() {});
  }

  //
}
