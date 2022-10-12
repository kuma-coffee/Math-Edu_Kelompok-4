// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:maths_edu/main/dashboard/materi.dart';

class Bab {
  final String nama;
  final String icon;
  const Bab({
    required this.nama,
    required this.icon,
  });
}

class listview2 extends StatefulWidget {
  const listview2({super.key});

  @override
  State<listview2> createState() => _listview2State();
}

class _listview2State extends State<listview2> {
  List<Bab> materi2 = [
    const Bab(
      nama: 'Fungsi',
      icon: 'assets/images/background.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materi 2'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: materi2.length,
          itemBuilder: (context, index) {
            final materi = materi2[index];

            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  //backgroundImage: Image.asset(materi.icon),
                ),
                title: Text(materi.nama),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MateriPage(),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
