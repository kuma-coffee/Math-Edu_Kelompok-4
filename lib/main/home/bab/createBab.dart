// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/bab/inputBab.dart';
import 'package:maths_edu/main/home/bab/updateBab.dart';
import 'package:maths_edu/main/home/subBab/createSubBab.dart';

class createBab extends StatefulWidget {
  const createBab({Key? key}) : super(key: key);

  @override
  State<createBab> createState() => _createBabState();
}

late DocumentReference _documentReference;
late DocumentSnapshot _documentSnapshot;

class _createBabState extends State<createBab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BAB'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InputBab(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('bab')
              .orderBy('timePost', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error:${snapshot.error}'));
            }
            if (snapshot.hasData) {
              QuerySnapshot data = snapshot.data!;
              List<QueryDocumentSnapshot> documents = data.docs;
              List<Map> items = documents
                  .map((e) => {'id': e.id, 'babName': e['babName']})
                  .toList();
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    QueryDocumentSnapshot x = snapshot.data!.docs[i];
                    Map listItems = items[i];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => createSubBab(listItems)),
                        );
                      },
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.network(
                            x['imgUrl'],
                            width: 52,
                            height: 52,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          x['babName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                        trailing: Wrap(
                          spacing: 12,
                          children: <Widget>[
                            Container(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.create,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            updateBab(listItems)),
                                  );
                                },
                              ),
                            ),
                            Container(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                onPressed: () async {
                                  _documentReference = FirebaseFirestore
                                      .instance
                                      .collection('bab')
                                      .doc(listItems['id']);
                                  // _documentSnapshot =
                                  //     await _documentReference.get().
                                  // var docID = _documentSnapshot.reference.id;

                                  ApiServices services = ApiServices();
                                  services
                                      .deleteDataToFirebase(_documentReference);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
