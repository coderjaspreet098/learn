import 'package:flutter/material.dart';

class PostModel {
  final String imageUrl;
  String title;
  bool isLiked;

  PostModel(this.imageUrl, this.title, this.isLiked);
}

void main() {
  runApp(MaterialApp(
    home: GridConcept(),
  ));
}

class GridConcept extends StatefulWidget {
  const GridConcept({Key? key}) : super(key: key);

  @override
  _GridConceptState createState() => _GridConceptState();
}

class _GridConceptState extends State<GridConcept> {
  final List<PostModel> posts = [
    PostModel('https://cdn.pixabay.com/photo/2023/08/18/15/02/dog-8198719_640.jpg', 'Title 1', false),
    PostModel('https://cdn.pixabay.com/photo/2023/08/18/15/02/dog-8198719_640.jpg', 'Title 2', false),
    PostModel('https://cdn.pixabay.com/photo/2023/08/18/15/02/dog-8198719_640.jpg', 'Title 3', false),
  ];

  void toggleLike(int index) {
    setState(() {
      posts[index].isLiked = !posts[index].isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Grid'),
      ),
      body: Container(
        color: Colors.grey,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
          ),
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Container(
                  color: Colors.greenAccent,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image(
                          image: NetworkImage(posts[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(posts[index].title),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 70,
                  child: IconButton(
                    icon: Icon(
                      posts[index].isLiked ? Icons.favorite : Icons.favorite_border,
                      color: posts[index].isLiked ? Colors.red : Colors.black,
                      size: 30.0,
                    ),
                    onPressed: () {
                      toggleLike(index);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
