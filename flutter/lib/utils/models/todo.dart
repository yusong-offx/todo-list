class Todo {
  int id;
  int userID;
  String title;
  bool done;
  String? contents;
  DateTime createDate;
  DateTime lastModifiedDate;

  Todo({
    required this.id,
    required this.userID,
    required this.done,
    required this.title,
    required this.contents,
    required this.createDate,
    required this.lastModifiedDate,
  });

  Todo.fromJSON(Map<String, dynamic> json)
      : id = json["id"],
        userID = json["user_id"],
        done = json["done"],
        title = json["title"],
        contents = json["contents"],
        createDate = DateTime.parse(json["create_date"]),
        lastModifiedDate = DateTime.parse(json["lastmodified_date"]);
}
