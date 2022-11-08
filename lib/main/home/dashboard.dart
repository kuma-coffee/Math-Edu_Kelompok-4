// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/main/home/bab/bab_list_page.dart';
import 'package:maths_edu/main/home/setting_page.dart';
import 'package:maths_edu/screens/chat/chat_page.dart';
import 'package:maths_edu/services/auth.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final User? user = Auth().currentUser;
  List adminUID = [
    'Si943Tqb6ePUaIQVrasOeH7vV6i1',
    'eP4cvriseCbf2ZyB2Z9bM4uegEC3'
  ];

  List<Tab> myTab = [
    Tab(
      text: "Kelas 7",
    ),
    Tab(
      text: "Kelas 8",
    ),
    Tab(
      text: "Kelas 9",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: 1,
        length: myTab.length,
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Math Edu")),
            bottom: TabBar(
              indicatorColor: Color.fromARGB(255, 17, 45, 95),
              indicatorWeight: 4,
              tabs: myTab,
            ),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    '${user?.displayName}',
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(
                    '${user?.email}',
                    style: TextStyle(fontSize: 18),
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: Ink.image(
                          image:
                              NetworkImage(user?.photoURL ?? 'User PhotoURL'),
                          fit: BoxFit.cover,
                          width: 128,
                          height: 128,
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Forum'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.download),
                //   title: Text(coba.contains('${user?.uid}').toString()),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => Coba(),
                //       ),
                //     );
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Setting'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => settingPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            Material(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Kelas7')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return BabList(adminUID, 'Kelas7');
                    }
                    return Container();
                  }),
            ),
            Material(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Kelas8')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return BabList(adminUID, 'Kelas8');
                    }
                    return Container();
                  }),
            ),
            Material(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Kelas9')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return BabList(adminUID, 'Kelas9');
                    }
                    return Container();
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
