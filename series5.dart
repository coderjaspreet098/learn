import 'package:flutter/material.dart';

class Post {
  final String id;
  final ImageProvider<Object> imageUrl;
  final String title;
  final String description;
  bool isLiked;

  Post({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.isLiked = false,
  });
}

class PostModel extends StatefulWidget {
  @override
  _PostModelState createState() => _PostModelState();
}

class _PostModelState extends State<PostModel> {
  final List<Post> posts = [
    Post(
      id: '1',
      imageUrl: NetworkImage(
          'https://cdn.pixabay.com/photo/2023/08/31/11/10/dahlia-8224979_1280.jpg'),
      title: 'Post 1',
      description: 'This is the first post.',
    ),
    Post(
      id: '2',
      imageUrl: NetworkImage(
          'https://cdn.pixabay.com/photo/2023/08/31/11/10/dahlia-8224979_1280.jpg'),
      title: 'Post 2',
      description: 'This is the second post.',
    ),
    // Add more posts here
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: posts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return buildPostCard(posts[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostCard(Post post) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: post.imageUrl,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.description),
          ),
          IconButton(
            icon: Icon(
              post.isLiked ? Icons.favorite : Icons.favorite_border,
              color: post.isLiked ? Colors.red : null,
            ),
            onPressed: () {
              // Toggle the like status
              setState(() {
                post.isLiked = !post.isLiked;
              });
            },
          ),
        ],
      ),
    );
  }
}

