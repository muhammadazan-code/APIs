// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:new_project/upload_images/images.dart';

void main() {
  runApp(const UploadImage());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           foregroundColor: Colors.white,
//           backgroundColor: Colors.blueAccent,
//           title: Center(
//             child: Text(
//               'Login Screen',
//               style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         body: UploadImage(),
//       ),
//     );
//   }
// }

// class CustomState extends StatefulWidget {
//   const CustomState({super.key});

//   @override
//   State<CustomState> createState() => _CustomStateState();
// }

// class _CustomStateState extends State<CustomState> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   void login(String password, String email) async {
//     try {
//       Response response = await post(
//         Uri.parse('https://reqres.in/api/login'),
//         body: {
//           "email": email,
//           "password": password,
//         },
//       );
//       if (response.statusCode == 200) {
//         Map<String, dynamic> datafromJson =
//             jsonDecode(response.body.toString());
//         print(datafromJson.containsKey('id'));
//         print('Login Successfully');
//       } else {
//         print('failed');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         spacing: 15,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           TextFormField(
//             controller: emailController,
//             decoration: InputDecoration(
//               labelText: 'Email',
//             ),
//           ),
//           TextFormField(
//             controller: passwordController,
//             decoration: InputDecoration(
//               labelText: 'Password',
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               login(passwordController.text.toString(),
//                   emailController.text.toString());
//               setState(() {});
//             },
//             child: Container(
//               alignment: Alignment.center,
//               height: 70,
//               width: 200,
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Text(
//                 'Login',
//                 style: TextStyle(
//                   fontSize: 40,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
