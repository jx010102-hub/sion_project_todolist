class TodoList {
  int? id; //user id

  String todo; //할일
  String memo; //메모
  String priority; // 우선순위
  String? initdate; // 입력일자
  bool? complete; //완료상태

  TodoList({
    this.id,

    required this.todo,

    required this.memo,
    required this.priority,
    this.initdate,
    this.complete = false,
  });

  TodoList.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      todo = res['todo'],
      memo = res['memo'],
      priority = res['priority'],
      initdate = res['initdate'],
      complete = res['complete'] == 1; // TRUE는 1, FALSE는 0
}
