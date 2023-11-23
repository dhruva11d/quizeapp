// // import'package:flutter/material.dart';
// // import 'dart:ui';
// // import 'package:quizeapp/GradientContainer.dart';
// //
// // void main(){
// //   runApp(HomeApp());
// // }
// // class HomeApp extends StatefulWidget {
// //   const HomeApp({super.key});
// //
// //   @override
// //   State<HomeApp> createState() => _HomeAppState();
// // }
// //
// // class _HomeAppState extends State<HomeApp> {
// //   @override
// //   Color c1 = const Color(0xFFf2b8d5);
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Have Fun"),backgroundColor: Colors.white54,elevation: 8,),
// //       body: Column(
// //         children: [
// //           Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple,Colors.pinkAccent]
// //              ),
// //             ),
// //
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(HomeApp());
// }
//
// class HomeApp extends StatefulWidget {
//   const HomeApp({super.key});
//
//   @override
//   State<HomeApp> createState() => _HomeAppState();
// }
//
// class _HomeAppState extends State<HomeApp> {
//   Color c1 = const Color(0xFFf2b8d5);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Have Fun"),
//         backgroundColor: Colors.white54,
//         elevation: 8,
//       ),
//       body: Center(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.purple, Colors.pinkAccent],
//             ),
//           ),
//           child: Column(
//             children: [
//               // Your content here
//               SizedBox(height: 20), // Add some space between the container and buttons
//               ElevatedButton(
//                 onPressed: () {
//                   // Add the action for the first button
//                   print("Button 1 pressed");
//                 },
//                 child: Text("Button 1"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Add the action for the second button
//                   print("Button 2 pressed");
//                 },
//                 child: Text("Button 2"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  Color c1 = const Color(0xFFf2b8d5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Have Fun"),
        backgroundColor: Colors.white54,
        elevation: 8,
      ),
      body: Container(
        width: double.infinity, // Set width to cover the whole page
        height: double.infinity, // Set height to cover the whole page
        padding: EdgeInsets.all(16.0), // Add padding as needed
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.pinkAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                  print("Button 1 pressed");
                },
                child: Text("Button 1"),
              ),
              ElevatedButton(
                onPressed: () {

                  print("Button 2 pressed");
                },
                child: Text("Button 2"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
