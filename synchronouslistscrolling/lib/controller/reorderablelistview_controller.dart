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

    await _database
        .child('itemList')
        .child(newId.toString())
        .update({'name': o['name']});

    await _database
        .child('itemList')
        .child(oldId.toString())
        .update({'name': n['name']});
  }



  Stream<DatabaseEvent> getDBevents() {
    return _database.child('itemList').onValue;
  }
}
