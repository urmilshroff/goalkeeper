class GoalClass {
  int id;
  String title;
  String body;
  DateTime deadLine;

  int get index => id;
  String get goalTitle => title;
  String get goalBody => body;
  DateTime get goalDeadLine => deadLine;

  set goalTitle(String newTitle) {
    this.title = newTitle;
  }

  set goalBody(String newBody) {
    this.body = newBody;
  }

  set goalDeadLine(DateTime deadline) {
    this.deadLine = deadline;
  }

  GoalClass(this.title, this.body, [this.deadLine]); //constructor
  GoalClass.withId(this.id, this.title, this.body, [this.deadLine]);

  GoalClass.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    body = map["body"];
    if (map['deadLine'] != null) deadLine = DateTime.parse(map['deadLine']);
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map["id"] = id;
    if (deadLine != null) map["deadLine"] = deadLine.toString();

    map["title"] = title;
    map["body"] = body;

    return map;
  }

  @override
  String toString() {
    return "[$id] - $title: $body (${deadLine.toString()})";
  }
}
