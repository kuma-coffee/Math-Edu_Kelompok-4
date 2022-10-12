import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maths_edu/lib/add_post.dart';
import 'package:maths_edu/lib/detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostsPage(),
    );
  }
}

class PostsPage extends StatelessWidget {
  PostsPage({Key? key}) : super(key: key) {
    _referencePosts = FirebaseFirestore.instance.collection('posts');
    _future = _referencePosts.get();
  }
  late CollectionReference _referencePosts;
  late Future<QuerySnapshot> _future;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error:${snapshot.error}'));
          }

          if (snapshot.hasData) {
            QuerySnapshot data = snapshot.data!;
            List<QueryDocumentSnapshot> documents = data.docs;
            List<Map> items = documents
                .map((e) => {'id': e.id, 'title': e['title']})
                .toList();

            return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Map thisItem = items[index] as Map;
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Detail(thisItem)));
                    },
                    title: Text(thisItem['title']),
                  );
                });
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
