// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ListTileWidget extends StatelessWidget {
//    ListTileWidget({Key? key, required this.name, required this.id}) : super(key: key);

//   String name;
//   int id;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       key: ValueKey(id),
//       height: Get.height * 0.1,
//       width: Get.width,
//       child: Column(
//         children: [
//           ListTile(
//             leading: Icon(Icons.insert_emoticon_outlined, color: Colors.yellow.shade900, size: 45.0),
//             title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.indigo))
//           ),
//           const Divider()
//         ],
//       ),
//     );
//   }
// }