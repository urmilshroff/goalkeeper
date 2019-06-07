class MyGoal {
  int id;
  String title;
  String body;

  int get index => id;
  String get goalTitle => title;
  String get goalBody => body;

  set goalTitle(String newTitle) {
    this.title = newTitle;
  }

  set goalBody(String newBody) {
    this.title = newBody;
  }

  MyGoal(this.title, this.body);
  MyGoal.withId(this.id, this.title, this.body);

  MyGoal.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    body = map["title"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["title"] = title;
    map["body"] = body;

    return map;
  }
}
