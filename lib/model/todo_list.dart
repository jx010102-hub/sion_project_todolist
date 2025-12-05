import 'dart:typed_data';

class TodoList {
  int? id; //user id
  String? name; // user
  String? goal; // user의 목표
  Uint8List? pimage; //user의 프로필 이미지

  String todo; //할일
  String memo; //메모
  String priority; // 우선순위
  String? initdate; // 입력일자

  TodoList({
    this.id,
    this.name,
    this.goal,

    required this.todo,

    this.pimage,
    required this.memo,
    required this.priority,
    this.initdate,
  });

  TodoList.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      name = res['name'],
      goal = res['goal'],
      pimage = res['pimage'],
      todo = res['todo'],
      memo = res['memo'],
      priority = res['priority'],
      initdate = res['initdate'];
}
