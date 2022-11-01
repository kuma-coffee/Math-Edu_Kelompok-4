// ignore_for_file: prefer_const_constructors, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';
import 'package:maths_edu/main/home/api.dart';
import 'package:maths_edu/main/home/bab/bab_list_page.dart';

class UpdateBab extends StatelessWidget {
  UpdateBab(this.data, {Key? key}) : super(key: key) {
    _documentReference =
        FirebaseFirestore.instance.collection('bab').doc(data['id']);
  }
  Map data;
  late DocumentReference _documentReference;
  String url = '';
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Bab'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: size.width * 0.8,
            decoration: BoxDecoration(
              //color: Color.fromARGB(255, 240, 239, 239),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kPrimaryColor, width: 1.0),
            ),
            child: Column(
              children: [
                //Bab Name textfield
                TextFormField(
                  controller: textController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Bab Name',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: size.height * 0.01,
          ),

          //Select Image Icon Password
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.5,
            child: ElevatedButton(
              onPressed: () {
                ApiServices services = ApiServices();
                services.updateDataToFirebase(
                    _documentReference, url, textController);
              },
              child: Text(
                'Select Image Icon',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                backgroundColor: kPrimaryColor,
              ),
            ),
          ),

          SizedBox(
            height: size.height * 0.05,
          ),

          //Save
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.8,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BabList(),
                  ),
                );
              },
              child: Text(
                'SAVE',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                backgroundColor: kPrimaryColor,
              ),
            ),
          ),

          // TextFormField(
          //   controller: textController,
          //   onChanged: (value) {},
          //   decoration: const InputDecoration(
          //     border: UnderlineInputBorder(),
          //     labelText: 'Enter New Bab Name',
          //   ),
          // ),
          // SizedBox(
          //   height: 16,
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     ApiServices services = ApiServices();
          //     services.updateDataToFirebase(
          //         _documentReference, url, textController);
          //   },
          //   child: const Text('Select New Image Icon'),
          // ),
          // SizedBox(
          //   height: 32,
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => BabList(),
          //       ),
          //     );
          //   },
          //   child: const Text('Save'),
          // ),
        ]),
      ),
    );
  }
}
