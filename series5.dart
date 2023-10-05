import 'dart:convert';

class User {
  String name;
  int age;

  User(this.name, this.age);

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
  };
}

class Tag {
  String name;
  int count;

  Tag(this.name, this.count);

  Map<String, dynamic> toJson() => {
    'name': name,
    'count': count,
  };
}

class Tutorial {
  String title;
  String description;
  User author;
  List<Tag> tags;

  Tutorial(this.title, this.description, this.author, this.tags);

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'author': author.toJson(),
    'tags': tags.map((tag) => tag.toJson()).toList(),
  };
}

void main() {
  User user = User('bezkoder', 21);
  String jsonUser = jsonEncode(user.toJson());
  print(jsonUser);

  List<Tag> tags = [Tag('tagA', 3), Tag('tagB', 6), Tag('tagC', 8)];
  String jsonTags = jsonEncode(tags.map((tag) => tag.toJson()).toList());
  print(jsonTags);

  Tutorial tutorial = Tutorial('Dart Tut#2', 'Tut#2 Description', user, tags);
  String jsonTutorial = jsonEncode(tutorial.toJson());
  print(jsonTutorial);
}
