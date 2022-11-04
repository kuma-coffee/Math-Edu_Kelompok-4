import 'package:flutter/material.dart';
import 'package:maths_edu/main/dashboard/setting.dart';
import 'package:maths_edu/screens/homePage/dump.dart';

class Dashboard extends StatelessWidget {
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
                  accountName: Text('Nama Pengguna'),
                  accountEmail: Text('example@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                          'https://assets.kompasiana.com/items/album/2021/03/24/blank-profile-picture-973460-1280-605aadc08ede4874e1153a12.png?t=o&v=770',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Forum'),
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => Dump()),
                  //   );
                  // },
                ),
                ListTile(
                  leading: Icon(Icons.download),
                  title: Text('Download'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => setting()),
                    );
                  },
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            Center(child: Text("Kelas 7")),
            Center(child: Text("Kelas 8")),
            Center(child: Text("Kelas 9"))
          ]),
        ),
      ),
    );
  }
}
