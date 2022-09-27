import 'package:flutter/material.dart';

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                  'Kelas 7',
                  style: TextStyle(fontSize: 18,),
              ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Kelas 8',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Kelas 9',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ],
            ),
            title: Center(child: Text("Math\'s Edu")),
          ),
          body: TabBarView(
            children: [
              Text(
                ' ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              Text(
                ' ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              Text(
                ' ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
            ],
          ),
        ),
      ),
    );
  }
}