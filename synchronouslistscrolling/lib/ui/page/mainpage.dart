import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:synchronouslistscrolling/controller/reorderablelistview_controller.dart';
import 'package:synchronouslistscrolling/data/artificialDatas.dart';
import 'package:synchronouslistscrolling/model/listitem.dart';
import 'package:synchronouslistscrolling/ui/page/add.dart';
import 'package:synchronouslistscrolling/ui/widget/listtile_widget.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          onPressed: () async {
            Get.to(() => AddPage());
          },
          child: const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Sürükle bırak',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.0)),
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: GetBuilder<ReorderableListViewController>(builder: (rc) {
            return StreamBuilder(
              stream: ref.child('itemList').onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  print('1 ${snapshot.data.snapshot.value.keys.toList()[1]}'); // burdan yürü //yıldızladığın delete e bak
                }
                return const SizedBox();
              },);
          }),
        ),
      ),
    );
  }

  Widget _listTileBuild({required String id, required String name}) => Slidable(
        key: ValueKey(id),
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {},
            autoClose: true,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Sil',
          ),
          SlidableAction(
            onPressed: (context) {},
            autoClose: true,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Düzenle',
          ),
        ]),
        child: SizedBox(
          height: Get.height * 0.1,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                  leading: Icon(Icons.insert_emoticon_outlined,
                      color: Colors.yellow.shade900, size: 45.0),
                  title: Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.indigo))),
              const Divider(height: 0.0)
            ],
          ),
        ),
      );
}

fromMap(Map<String?, dynamic> json) {
  return json['name'];
}



// SizedBox(
//         height: Get.height,
//         width: Get.width,
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               vertical: Get.height * 0.03, horizontal: Get.width * 0.05),
//           child: GetBuilder<ReorderableListViewController>(builder: (rc) {
//             return ReorderableListView.builder(
//               physics: const BouncingScrollPhysics(
//                   parent: AlwaysScrollableScrollPhysics()),
//               onReorder: (oldIndex, newIndex) {
//                 print('newIndex: $newIndex');
//                 print('oldIndex: $oldIndex');
//                 rc.reorderlist(oldIndex, newIndex);
//               },
//               itemCount: rc.artificialDatas.length,
//               itemBuilder: (context, index) {
//                 final person = rc.artificialDatas[index];
//                 return _listTileBuild(id: person.id!, name: person.name);
//               },
//             );
//           }),
//         ),
//       ),








// Center(child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(rc.string1, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
//                   Text(rc.string2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0))
//                 ],
//               )),




// FloatingActionButton(
//                   onPressed: () async{
//                     //veri okumayı öğren
//                     // // String o = '';
//                     // // String n = '';
//                     // // deneme.child('2/name').onValue.listen((event) { 
//                     // //   final Object? result = event.snapshot.value;
//                     // //   o = result.toString();
//                     // // });
//                     // // deneme.child('1/name').onValue.listen((event) { 
//                     // //   final Object? result = event.snapshot.value;
//                     // //   n = result.toString();
//                     // // });
//                     // // deneme.child('1').update({'name' : o});
//                     // // deneme.child('2').update({'name' : n});
//                     // final o = await deneme.child('2/name').get();
//                     // final n = await deneme.child('1/name').get();
//                     // if(o.exists && n.exists){
//                     //   // print(o.value);
//                     //   // print(n.value);
//                     //   deneme.child('1').update({'name': o.value});
//                     //   deneme.child('2').update({'name' : n.value});
//                     // }
//                     // else{
//                     //   log('data not available');
//                     // }
//                     rc.updateString();
//                   },
//                   child: const Icon(Icons.download),
//                 ),



// await deneme.child('0').set({'name':'ali'});
// await deneme.child('1').set({'name':'buse'});




// StreamBuilder(
//               stream: ref.child('itemList').onValue,
//               //rc.getListItems(),
//               builder: (context, AsyncSnapshot<List<ListItem>> snapshot) {
//                 final tileList = <Widget>[];
//                 if (snapshot.hasData) {
//                   final itemList = snapshot.data as List<ListItem>;
//                   tileList.addAll(
//                     itemList.map((item) {
//                       return _listTileBuild(id: item.name, name: item.name);
//                     }),
//                   );
//                   return Expanded(
//                     //reorderable listview
//                     child: ListView(
//                       children: tileList,
//                     ),
//                   );
//                 } else {
//                   return SizedBox(
//                       height: Get.height,
//                       width: Get.width,
//                       child: const Center(child: CircularProgressIndicator()));
//                 }
//               },
//             );