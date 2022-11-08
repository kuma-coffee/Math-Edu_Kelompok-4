// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/services/auth.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  final User? user = Auth().currentUser;
  TextEditingController messageController = TextEditingController();
  TextEditingController replyController = TextEditingController();
  bool val = true;
  Timer? timer;
  String? hintText;

  void incrementCounter(id) {
    DocumentReference likeCount =
        FirebaseFirestore.instance.collection('messages').doc(id['id']);
    likeCount.update({'likeCount': FieldValue.increment(1)});
    likeCount.update({'like': true});
  }

  void decrementCounter(id) {
    DocumentReference likeCount =
        FirebaseFirestore.instance.collection('messages').doc(id['id']);
    likeCount.update({'likeCount': FieldValue.increment(-1)});
    likeCount.update({'like': false});
  }

  void incrementCounterReply(messageID, replyID) {
    DocumentReference likeCount =
        FirebaseFirestore.instance.collection('messages').doc(messageID['id']);
    CollectionReference likeCountReplyCol =
        likeCount.collection('replyMessage');
    DocumentReference likeCountReplyRef = likeCountReplyCol.doc(replyID['id']);
    likeCountReplyRef.update({'likeCount': FieldValue.increment(1)});
    likeCountReplyRef.update({'like': true});
  }

  void decrementCounterReply(messageID, replyID) {
    DocumentReference likeCount =
        FirebaseFirestore.instance.collection('messages').doc(messageID['id']);
    CollectionReference likeCountReplyCol =
        likeCount.collection('replyMessage');
    DocumentReference likeCountReplyRef = likeCountReplyCol.doc(replyID['id']);
    likeCountReplyRef.update({'likeCount': FieldValue.increment(-1)});
    likeCountReplyRef.update({'like': false});
  }

  Widget timeWidget(
      minuteDifference, hourDifference, dayDifference, weekDifference) {
    if (dayDifference > 30) {
      return Text(
        '${weekDifference.round()}w',
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black,
        ),
      );
    } else if (hourDifference > 24) {
      return Text(
        '${dayDifference}d',
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black,
        ),
      );
    } else if (minuteDifference > 60) {
      return Text(
        '${hourDifference}h',
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black,
        ),
      );
    } else {
      return Text(
        '${minuteDifference}s',
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black,
        ),
      );
    }
  }

  void _showReply(id) {
    DocumentReference reply =
        FirebaseFirestore.instance.collection('messages').doc(id['id']);
    reply.update({'val': true});

    setState(() {
      val = false;
    });
  }

  void _hiddenReply(id) {
    DocumentReference reply =
        FirebaseFirestore.instance.collection('messages').doc(id['id']);
    reply.update({'val': false});

    setState(() {
      val = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        //backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          // input chat
          Visibility(
            child: inputMassage(),
            visible: val,
          )
        ],
      ),
    );
  }

  chatMessages() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('messages')
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
                  .map((e) => {'id': e.id, 'usernmae': e['username']})
                  .toList();
              return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot x = snapshot.data!.docs[index];
                  Map listItems = items[index];
                  Timestamp currentTime = Timestamp.fromMicrosecondsSinceEpoch(
                      DateTime.now().millisecondsSinceEpoch);
                  Timestamp time =
                      x['timePost'] == null ? currentTime : x['timePost'];
                  DateTime date = time.toDate();
                  DateTime now = DateTime.now();
                  int minuteDifference = now.difference(date).inMinutes;
                  int hourDifference = now.difference(date).inHours;
                  int dayDifference = now.difference(date).inDays;
                  double weekDifference = dayDifference / 7;

                  return Column(
                    children: [
                      ListTile(
                        //dense: true,
                        isThreeLine: true,
                        leading: ClipOval(
                          child: Image.network(
                            x['profileImg'],
                            width: 37,
                            height: 37,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Row(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                x['username'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                x['message'],
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: timeWidget(
                                      minuteDifference,
                                      hourDifference,
                                      dayDifference,
                                      weekDifference),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      '${x['likeCount']} like',
                                      style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      _showReply(listItems);
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      textStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    child: Text(
                                      'Reply',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: x['like']
                            ? IconButton(
                                iconSize: 15,
                                icon: const Icon(
                                  CupertinoIcons.heart_fill,
                                  color: Colors.red,
                                ),
                                onPressed: () => decrementCounter(listItems),
                              )
                            : IconButton(
                                iconSize: 15,
                                icon: const Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.black,
                                ),
                                onPressed: () => incrementCounter(listItems),
                              ),
                      ),
                      //input reply
                      Visibility(
                        child: inputReply(listItems),
                        visible: x['val'],
                      ),
                      //Reply message
                      replyMessage(listItems),
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  replyMessage(messageID) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('messages').doc(messageID['id']);
    CollectionReference referenceReply =
        documentReference.collection('replyMessage');
    Stream<QuerySnapshot> streamReply =
        referenceReply.orderBy('timePost', descending: true).snapshots();
    return StreamBuilder(
      stream: streamReply,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error:${snapshot.error}'));
        }
        if (snapshot.hasData) {
          QuerySnapshot data = snapshot.data!;
          List<QueryDocumentSnapshot> documents = data.docs;
          List<Map> items = documents
              .map((e) => {'id': e.id, 'username': e['username']})
              .toList();

          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot x = snapshot.data!.docs[index];
              Map listItems = items[index];
              Timestamp currentTime = Timestamp.fromMicrosecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch);
              Timestamp time =
                  x['timePost'] == null ? currentTime : x['timePost'];
              DateTime date = time.toDate();
              DateTime now = DateTime.now();
              int minuteDifference = now.difference(date).inMinutes;
              int hourDifference = now.difference(date).inHours;
              int dayDifference = now.difference(date).inDays;
              double weekDifference = dayDifference / 7;

              return Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      isThreeLine: true,
                      leading: ClipOval(
                        child: Image.network(
                          x['profileImg'],
                          width: 37,
                          height: 37,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              x['username'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              x['reply'],
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: timeWidget(
                                    minuteDifference,
                                    hourDifference,
                                    dayDifference,
                                    weekDifference),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '${x['likeCount']} like',
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: x['like']
                          ? IconButton(
                              iconSize: 15,
                              icon: const Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  decrementCounterReply(messageID, listItems),
                            )
                          : IconButton(
                              iconSize: 15,
                              icon: const Icon(
                                CupertinoIcons.heart,
                                color: Colors.black,
                              ),
                              onPressed: () =>
                                  incrementCounterReply(messageID, listItems),
                            ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  inputMassage() {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              width: size.width * 0.73,
              decoration: BoxDecoration(
                  //color: Color.fromARGB(255, 240, 239, 239),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kPrimaryColor, width: 1.0)),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                controller: messageController,
                onChanged: (value) {},
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Send a message ...',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                  border: InputBorder.none,
                ),
              )),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: sendMessage,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                  child: Icon(
                Icons.send,
                color: Colors.white,
              )),
            ),
          )
        ]),
      ),
    );
  }

  inputReply(id) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                width: size.width * 0.61,
                decoration: BoxDecoration(
                    //color: Color.fromARGB(255, 240, 239, 239),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kPrimaryColor, width: 1.0)),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  controller: replyController,
                  onChanged: (value) {},
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Reply a message...",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                    border: InputBorder.none,
                  ),
                )),
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
              onTap: () {
                sendReply(id);
                _hiddenReply(id);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                    child: Icon(
                  Icons.send,
                  color: Colors.white,
                )),
              ),
            )
          ]),
        ),
      ),
    );
  }

  sendMessage() {
    CollectionReference message =
        FirebaseFirestore.instance.collection('messages');

    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> addMessage = {
        'id': message.doc().id,
        'uid': '${user?.uid}',
        'username': '${user?.displayName}',
        'profileImg': '${user?.photoURL}',
        'message': messageController.text.trim(),
        'timePost': FieldValue.serverTimestamp(),
        'likeCount': 0,
        'like': false,
        'val': false,
      };
      message.add(addMessage);
    }

    setState(() {
      messageController.clear();
    });
    return print('Success adding message');
  }

  sendReply(messageID) {
    if (replyController.text.isNotEmpty) {
      DocumentReference messageRef = FirebaseFirestore.instance
          .collection('messages')
          .doc(messageID['id']);
      CollectionReference reply = messageRef.collection('replyMessage');
      Map<String, dynamic> addReply = {
        'id': reply.doc().id,
        'uid': '${user?.uid}',
        'username': '${user?.displayName}',
        'profileImg': '${user?.photoURL}',
        'reply': replyController.text.trim(),
        'timePost': FieldValue.serverTimestamp(),
        'likeCount': 0,
        'like': false,
      };
      reply.add(addReply);
    }
    setState(() {
      replyController.clear();
    });
    //_changeReplyToMassage;
    return print('Success adding reply');
  }
}
