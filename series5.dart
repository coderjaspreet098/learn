import 'dart:convert';

class User {
  String name;
  int age;

  User(this.name, this.age);

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['name'] as String,
      json['age'] as int,
    );
  }
}

class Tag {
  String name;
  int count;

  Tag(this.name, this.count);

  Map<String, dynamic> toJson() => {
        'name': name,
        'count': count,
      };

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      json['name'] as String,
      json['count'] as int,
    );
  }
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

  factory Tutorial.fromJson(Map<String, dynamic> json) {
    return Tutorial(
      json['title'] as String,
      json['description'] as String,
      User.fromJson(json['author'] as Map<String, dynamic>),
      (json['tags'] as List<dynamic>)
          .map((tag) => Tag.fromJson(tag as Map<String, dynamic>))
          .toList(),
    );
  }
}

void main() {
  // Create a User object
  User user = User('bezkoder', 21);

  // Encode the User object to JSON
  String jsonUser = jsonEncode(user.toJson());
  print('User JSON: $jsonUser');

  // Decode the JSON back to a User object
  Map<String, dynamic> decodedUser = jsonDecode(jsonUser);
  User userFromJson = User.fromJson(decodedUser);
  print('User from JSON: ${userFromJson.name}, ${userFromJson.age}');

  // Create a list of Tag objects
  List<Tag> tags = [Tag('tagA', 3), Tag('tagB', 6), Tag('tagC', 8)];

  // Encode the list of Tag objects to JSON
  String jsonTags = jsonEncode(tags.map((tag) => tag.toJson()).toList());
  print('Tags JSON: $jsonTags');

  // Decode the JSON back to a list of Tag objects
  List<dynamic> decodedTags = jsonDecode(jsonTags);
  List<Tag> tagsFromJson =
      decodedTags.map((tag) => Tag.fromJson(tag)).toList();
  print('Tags from JSON:');
  tagsFromJson.forEach((tag) {
    print('${tag.name}, ${tag.count}');
  });

  // Create a Tutorial object
  Tutorial tutorial = Tutorial('Dart Tut#2', 'Tut#2 Description', user, tags);

  // Encode the Tutorial object to JSON
  String jsonTutorial = jsonEncode(tutorial.toJson());
  print('Tutorial JSON: $jsonTutorial');

  // Decode the JSON back to a Tutorial object
  Map<String, dynamic> decodedTutorial = jsonDecode(jsonTutorial);
  Tutorial tutorialFromJson = Tutorial.fromJson(decodedTutorial);
  print('Tutorial from JSON:');
  print('Title: ${tutorialFromJson.title}');
  print('Description: ${tutorialFromJson.description}');
  print('Author: ${tutorialFromJson.author.name}, ${tutorialFromJson.author.age}');
  print('Tags:');
  tutorialFromJson.tags.forEach((tag) {
    print('${tag.name}, ${tag.count}');
  });
}
