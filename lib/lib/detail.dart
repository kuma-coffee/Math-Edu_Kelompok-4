import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  Detail(this.data, {Key? key}) : super(key: key) {
    _documentReference =
        FirebaseFirestore.instance.collection('posts').doc(data['id']);
    _referenceComments = _documentReference.collection('comments');
    _streamComments =
        _referenceComments.orderBy('posted_on', descending: true).snapshots();
  }
  Map data;
  late DocumentReference _documentReference;
  late CollectionReference _referenceComments;
  late Stream<QuerySnapshot> _streamComments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                TextEditingController controller = TextEditingController();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controller,
                        onChanged: (value) {},
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Map<String, dynamic> commentsToAdd = {
                              'comment_text': controller.text.trim(),
                              'posted_on': FieldValue.serverTimestamp()
                            };
                            _referenceComments.add(commentsToAdd);
                            Navigator.of(context).pop();
                          },
                          child: Text('Submit'))
                    ],
                  ),
                );
              },
            );
          },
          child: Icon(Icons.send),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                color: Colors.black12,
                padding: EdgeInsets.all(18),
                child: Text(data['title'])),
            Expanded(
              child: buildCommetsListView(),
            ),
          ],
        ));
  }

  Widget buildCommetsListView() {
    return StreamBuilder(
        stream: _streamComments,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            QuerySnapshot data = snapshot.data;
            List<QueryDocumentSnapshot> documents = data.docs;
            List<Map> items = documents
                .map((e) => {'id': e.id, 'comment_text': e['comment_text']})
                .toList();

            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Map thisItem = items[index];
                  return ListTile(
                    title: Text(thisItem['comment_text'].toString()),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
