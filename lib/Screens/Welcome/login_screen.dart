import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //Logo
          Image.asset('assets/launch_image.png',
          height: 300.0,
          width: 300.0,),

          //Email
          Padding(
            padding : const EdgeInsets.symmetric ( horizontal : 25.0 ) ,
            child : Container (
              decoration : BoxDecoration (
                color : Colors.grey [ 200 ] ,
              border : Border.all ( color : Colors.white ) ,
                borderRadius : BorderRadius.circular ( 29 ) ,
              ) , 
              child : Padding (
                padding : const EdgeInsets.only ( left : 20.0 ) ,
                child : TextField (
                decoration : InputDecoration (
                    border : InputBorder.none ,
                    hintText : ' Email ' ,
                  ) , 
                ) , 
              ) , 
            ) , 
          ),
          SizedBox ( height : 10 ),
          
          //Password
          Padding (
            padding : const EdgeInsets.symmetric ( horizontal : 25.0 ) ,
            child : Container (
            decoration : BoxDecoration (
                color : Colors.grey [ 200 ] ,
                border : Border.all ( color : Colors.white ) ,
                borderRadius : BorderRadius.circular ( 29 ) ,
              ) , 
              child : Padding (
                padding : const EdgeInsets.only ( left : 20.0 ) ,
                child : TextField (
                  obscureText : true ,
                  decoration : InputDecoration (
                    border : InputBorder.none ,
                    hintText : ' Password ' ,
                  ) , 
                ) , 
              ) , 
            ) , 
          ) , 
          SizedBox ( height : 20 ) ,

          //Sign in button
          Padding (
            padding : const EdgeInsets.symmetric ( horizontal : 25.0 ) ,
              child : Container (
              padding : EdgeInsets.all ( 20 ) ,
              decoration : BoxDecoration (
                  color : Colors.deepPurple ,
                borderRadius : BorderRadius.circular ( 29 ) ,
              ) , 
                child : Center (
                child : Text (
                    ' Sign In ' ,
                  style : TextStyle (
                      color : Colors.white ,
                    fontWeight : FontWeight.bold ,
                      //fontSize : 14 ,
                  ) , 
                  ) , 
                ) , 
              ) , 
            ) , 
            SizedBox ( height : 10 ) ,

          //not a member? register now
          Row (
            mainAxisAlignment : MainAxisAlignment.center ,
            // ignore: prefer_const_literals_to_create_immutables
            children : [
              Text (
                  ' Not a member ? ' ,
                style : TextStyle (
                  fontWeight : FontWeight.bold ,
                ) , 
              ) , 
              Text (
                  ' Register now ' ,
                style : TextStyle (
                  color : Colors.blue ,
                  fontWeight : FontWeight.bold ,
                ) , 
              ) , 
            ],
          ) , 

        ],),
      )
    );
  }
}