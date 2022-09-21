import 'package:flutter/material.dart';
import 'package:maths_edu/constants.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              child: Image.asset(
                'assets/images/launch_image.png',
                height: size.height * 0.28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),

//               Image.asset(
//                 'assets/images/launch_image.png',
//                 height: 230.0,
//                 width: 230.0,
//               ),
//               SizedBox(
//                 height: 30,
//               ),

//               //Hello
//               Text(
//                 'LOGIN',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 36,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 'Login to your account',
//                 style: TextStyle(fontSize: 20),
//               ),
//               SizedBox(
//                 height: 50,
//               ),

//               //email textfield
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 20.0),
//                     child: TextField(
//                       decoration: InputDecoration(
//                           border: InputBorder.none, hintText: 'Email'),
//                     ),
//                   ),
//                 ),
//               ),

//               SizedBox(
//                 height: 10,
//               ),
//               //password textfield
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 20.0),
//                     child: TextField(
//                       decoration: InputDecoration(
//                           border: InputBorder.none, hintText: 'Password'),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),

//               //loggin button
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                       color: Colors.blue[800],
//                       borderRadius: BorderRadius.circular(12)),
//                   child: Center(
//                     child: Text(
//                       'Login',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//               ),

//               //not a member? register now
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Don\'t have an Account? '),
//                   Text(
//                     'Sign Up',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
