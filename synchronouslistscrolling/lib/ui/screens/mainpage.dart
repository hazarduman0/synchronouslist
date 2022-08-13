import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:synchronouslistscrolling/controller/reorderablelistview_controller.dart';
import 'package:synchronouslistscrolling/ui/screens/add.dart';
import 'package:synchronouslistscrolling/ui/screens/edit.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  DatabaseReference ref = FirebaseDatabase.instance.ref();

  final ReorderableListViewController _rc = Get.find();

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
              stream: rc.getDBevents(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var allData = snapshot.data!.snapshot.value;
                  if (allData != null) {
                    var keys = allData.keys.toList();
                    var values = allData.values.toList();
                    // print('allData: ${allData}');
                    // print('keys: ${keys}');
                    // print('values: ${values}');
                    return SizedBox(
                      height: Get.height * 0.8,
                      width: Get.width,
                      child: ReorderableListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: keys.length,
                        onReorder: (oldIndex, newIndex) {
                          // print('keys[oldIndex].toString(): ${keys[oldIndex].toString()}');
                          // print('values[oldIndex]: ${values[oldIndex]}');
                          // print('keys[newIndex].toString(): ${keys[newIndex].toString()}');
                          // print('values[newIndex]: ${values[newIndex]}');
                          // print('oldIndex: $oldIndex');
                          // print('newIndex: $newIndex');
                          final newIndx = newIndex > oldIndex ? newIndex - 1 : newIndex;
                          Map<String,dynamic> oldIndexMap = {keys[oldIndex].toString() : values[oldIndex]};
                          Map<String,dynamic> newIndexMap = {keys[newIndx].toString() : values[newIndx]};
                          rc.reorderlist(oldIndexMap,newIndexMap);
                        },
                        itemBuilder: (context, index) {
                          return _listTileBuild(
                              id: keys[index].toString(),
                              name: values[index]['name']);
                        },
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: const Center(
                          child: Text('Veri yok',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold))),
                    );
                  }

                } else {
                  return SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    );
                }
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _listTileBuild({required String id, required String name}) => Slidable(
        key: ValueKey(id),
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) async{
              await ref.child('itemList').child(id).remove(); 
            },
            autoClose: true,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Sil',
          ),
          SlidableAction(
            onPressed: (context) {
              _rc.setInitialValue(name);
              Get.to(() => EditPage(id: id));
            },
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

