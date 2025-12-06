class UserList {
  int? id;
  String name;
  String? userimages;

  UserList({this.id, required this.name, this.userimages});

  UserList.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      name = res['name'],
      userimages = res['userimages'];
}
