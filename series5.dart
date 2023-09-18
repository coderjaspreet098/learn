import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostModel {
  final String imageUrl;
  final String title;
  final String description;
  bool isLiked;

  PostModel(this.imageUrl, this.title, this.description, {this.isLiked = false});
}

class MyApp5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid View Example',
      home: GridConcept2(),
    );
  }
}

class GridConcept2 extends StatefulWidget {
  const GridConcept2({Key? key}) : super(key: key);

  @override
  _GridConceptState createState() => _GridConceptState();
}

class _GridConceptState extends State<GridConcept2> {
  final List<PostModel> posts = [];
  File? _selectedImage;
  String title = '';
  String description = '';

  void _addPost(String imageUrl, String title, String description) {
    setState(() {
      posts.add(PostModel(imageUrl, title, description));
      _selectedImage = null;
    });
    Navigator.pop(context);
  }

  Future<void> _openGallery() async {
    final picker = ImagePicker();

    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _showBottomSheet() {
    String tempTitle = '';
    String tempDescription = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState1) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (_selectedImage != null)
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(_selectedImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        else
                          ElevatedButton(
                            onPressed: () {
                              _openGallery();
                            },
                            child: Text('Select Image'),
                          ),
                        SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) {
                            tempTitle = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Title',
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) {
                            tempDescription = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Description',
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_selectedImage != null &&
                                tempTitle.isNotEmpty &&
                                tempDescription.isNotEmpty) {
                              _addPost(
                                  _selectedImage!.path, tempTitle, tempDescription);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please fill in all fields and select an image.'),
                                ),
                              );
                            }
                          },
                          child: Text('Add'),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        _selectedImage = null;
        title = '';
        description = '';
      });
    });
  }

  void _showdeleteconfirmationdialouge(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure to delete the pic ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                _deletepost(index);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _deletepost(int index) {
    setState(() {
      posts.removeAt(index);
      _selectedImage = null;
    });
  }

  void _toggleLike(int index) {
    setState(() {
      posts[index].isLiked = !posts[index].isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showBottomSheet();
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      children: [
                        Image(
                          image: FileImage(File(posts[index].imageUrl)),
                          height: 120,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Text(posts[index].title),
                        Text(posts[index].description),
                      ],
                    ),
                    Positioned(
                      top: 120,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _showdeleteconfirmationdialouge(index);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.blue,
                          size: 36.0,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _toggleLike(index);
                        },
                        child: Icon(
                          posts[index].isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: posts[index].isLiked
                              ? Colors.red
                              : Colors.grey,
                          size: 36.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
