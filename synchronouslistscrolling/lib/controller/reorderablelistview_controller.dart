import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ReorderableListViewController extends GetxController {

  final _database = FirebaseDatabase.instance.ref();
  
  RxString _initialValue = ''.obs;
  RxList<String> _addedWords = <String>[].obs;

  String get initialValue => _initialValue.value;
  List<String> get addedWords => _addedWords;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getString();
  }

  setInitialValue(String text){
    _initialValue.value = text;
    update();
  }

  addTempStringList(String text) {
    _addedWords.add(text);
    update();
  }

  resetTempStringList() {
    _addedWords.clear();
    update();
  }

  reorderlist(
      Map<String, dynamic> oldIndex, Map<String, dynamic> newIndex) async {
    final o = oldIndex.values.toList().first;
    final n = newIndex.values.toList().first;

    final oldId = oldIndex.keys.toList().first;
    final newId = newIndex.keys.toList().first;

    //to list vermediğinde (.....) şeklinde veriyor
    print('o: $o');
    print('n: $n');


    await _database
        .child('itemList')
        .child(newId.toString())
        .update({'name': o['name']});

    await _database
        .child('itemList')
        .child(oldId.toString())
        .update({'name': n['name']});

    // await updateItems(o, n, oldId, newId);
  }

  // Future<void> updateItems(dynamic o, dynamic n, String oldId, String newId) async{
  //   await _database
  //       .child('itemList')
  //       .child(newId.toString())
  //       .update({'name': o['name']});

  //   await _database
  //       .child('itemList')
  //       .child(oldId.toString())
  //       .update({'name': n['name']});
  // }

  Stream<DatabaseEvent> getDBevents() {
    return _database.child('itemList').onValue;
    //.orderByKey()
    //.orderByChild('time')
  }

  // Stream<List<ListItem>> getListItems() {
  //   final itemStream = _database.child('itemList').onValue;
  //   final streamToPublish = itemStream.map((event) {
  //     final itemMap = Map<String, dynamic>.from(
  //         event.snapshot.value as Map<String, dynamic>);
  //     final itemList = itemMap.entries.map((e) {
  //       return ListItem.fromRTDB(Map<String, dynamic>.from(e.value));
  //     }).toList();
  //     return itemList;
  //   });
  //   return streamToPublish;
  // }

}
