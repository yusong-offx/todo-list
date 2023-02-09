class Todo {
  bool done;
  String title;
  String? contents;
  DateTime createDate;
  DateTime lastModifiedDate;

  Todo({
    required this.done,
    required this.title,
    required this.contents,
    required this.createDate,
    required this.lastModifiedDate,
  });

  Todo.fromJSON(Map<String, dynamic> json)
      : done = json["done"],
        title = json["title"],
        contents = json["contens"],
        createDate = json["createDate"],
        lastModifiedDate = json["lastModifiedDate"];
}
