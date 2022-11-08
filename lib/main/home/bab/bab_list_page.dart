// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/bab/input_bab_page.dart';
import 'package:maths_edu/main/home/bab/update_bab_page.dart';
import 'package:maths_edu/main/home/subBab/subBab_list_page.dart';
import 'package:maths_edu/services/auth.dart';

class BabList extends StatefulWidget {
  List adminUID;
  String kelasId;
  BabList(this.adminUID, this.kelasId, {Key? key}) : super(key: key) {
    _adminUID = adminUID;
    _kelasId = kelasId;
  }

  @override
  State<BabList> createState() => _BabListState();
}

late List _adminUID;
late String _kelasId;
late DocumentReference _documentReference;

class _BabListState extends State<BabList> {
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(_kelasId)
              .orderBy('timePost', descending: false)
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
                              builder: (context) =>
                                  SubBabList(_adminUID, _kelasId, listItems)),
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
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        trailing: _adminUID.contains('${user?.uid}')
                            ? Wrap(
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
                                              builder: (context) => UpdateBab(
                                                  _kelasId, listItems)),
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
                                            .collection(_kelasId)
                                            .doc(listItems['id']);
                                        ApiServices services = ApiServices();
                                        services.deleteDataToFirebase(
                                            _documentReference);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: _adminUID.contains('${user?.uid}')
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InputBab(_kelasId),
                  ),
                );
              },
            )
          : null,
    );
  }
}
