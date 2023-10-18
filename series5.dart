import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyHomePage9 extends StatefulWidget {
  @override
  _MyHomePage9State createState() => _MyHomePage9State();
}

class _MyHomePage9State extends State<MyHomePage9> {
  final String apiUrl = 'https://reqres.in/api/users/2';

  Future<void> deleteData() async {
    final response = await http.delete(
      Uri.parse(apiUrl),
      // headers: {
      //
      // },
    );

    if (response.statusCode == 204) {
      print('DELETE request successful');
    } else {
      print('DELETE request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP DELETE Request Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            deleteData();
          },
          child: Text('Delete Data'),
        ),
      ),
    );
  }
}
