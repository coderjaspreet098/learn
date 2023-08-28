import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class DataModel {
  String field1;
  String field2;
  // You can add more fields as needed

  DataModel({required this.field1, required this.field2});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Passing Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController field1Controller = TextEditingController();
  TextEditingController field2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: field1Controller,
              decoration: InputDecoration(labelText: 'Field 1'),
            ),
            TextField(
              controller: field2Controller,
              decoration: InputDecoration(labelText: 'Field 2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                DataModel dataModel = DataModel(
                  field1: field1Controller.text,
                  field2: field2Controller.text,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisplayScreen(dataModel: dataModel),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayScreen extends StatelessWidget {
  final DataModel dataModel;

  DisplayScreen({required this.dataModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Field 1: ${dataModel.field1}'),
            Text('Field 2: ${dataModel.field2}'),
            // You can add more Text widgets to display other fields
          ],
        ),
      ),
    );
  }
}
