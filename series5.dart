class MyItem {
  var id;
  String? name;
  int? age;
  String? otherProperty;

  MyItem({
    this.id,
    this.name,
    this.age,
    this.otherProperty,
  });

  factory MyItem.fromJson(Map<String, dynamic> json) {
    return MyItem(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      otherProperty: json['otherProperty'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'otherProperty': otherProperty,
    };
    return data;
  }
}
void main() {
  final myItem = MyItem(
    id: 1,
    name: 'Sample Item',
    age: 25,
    otherProperty: 'Some value',
  );
  
  final myItemJson = myItem.toJson();
  print('MyItem JSON: $myItemJson');
  
  final parsedMyItem = MyItem.fromJson({
    'id': 2,
    'name': 'Another Item',
    'age': 30,
    'otherProperty': 'Another value',
  });
  print('Parsed MyItem - ID: ${parsedMyItem.id}, Name: ${parsedMyItem.name}, Age: ${parsedMyItem.age}, Other Property: ${parsedMyItem.otherProperty}');
}
