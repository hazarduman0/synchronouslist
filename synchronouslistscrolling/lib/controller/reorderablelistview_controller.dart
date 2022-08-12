import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:synchronouslistscrolling/model/listitem.dart';

class ReorderableListViewController extends GetxController {
  //DatabaseReference ref = FirebaseDatabase.instance.ref();
  final _database = FirebaseDatabase.instance.ref();
  // RxList<ListItem> _artificialDatas = <ListItem>[
  //   ListItem(name: 'hazar'),
  //   ListItem(name: 'ilker'),
  //   ListItem(name: 'özge'),
  //   ListItem(name: 'eren'),
  //   ListItem(name: 'cemil'),
  //   ListItem(name: 'elif'),
  //   ListItem(name: 'türkan'),
  //   ListItem(name: 'yılmaz'),
  //   ListItem(name: 'sibel'),
  //   ListItem(name: 'kaan')
  // ].obs;
  RxString _string1 = ''.obs;
  RxString _string2 = ''.obs;
  RxList<String> _addedWords = <String>[].obs;

  String get string1 => _string1.value;
  String get string2 => _string2.value;
  List<String> get addedWords => _addedWords;
  // List<ListItem> get artificialDatas => _artificialDatas;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getString();
  }

  addTempStringList(String text){
    _addedWords.add(text);
    update();
  }

  resetTempStringList(){
    _addedWords.clear();
    update();
  }

  reorderlist(int oldIndex, int newIndex) {
    final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
    // final person = _artificialDatas.removeAt(oldIndex);
    // _artificialDatas.insert(index, person);
    update();
  }

  Stream<List<ListItem>> getListItems() {
    final itemStream = _database.child('itemList').onValue;
    final itemGetStream = _database.child('itemList').get().asStream();
    print('itemStream: ${itemStream}');
    print('itemGetStream ${itemGetStream}');
    final streamToPublish = itemStream.map((event) {
      final itemMap = Map<String, dynamic>.from(
          event.snapshot.value as Map<String, dynamic>);
      final itemList = itemMap.entries.map((e) {
        return ListItem.fromRTDB(Map<String, dynamic>.from(e.value));
      }).toList();
      return itemList;
    });
    return streamToPublish;
  }

  // getString() async {
  //   final deneme = ref.child('deneme');
  //   final str1 = await deneme.child('0/name').get();
  //   final str2 = await deneme.child('1/name').get();
  //   _string1.value = str1.value as String;
  //   _string2.value = str2.value as String;
  //   update();
  //   final dnm = await deneme.get();
  //   print('denemeKey: ${dnm.key}');
  //   print('denemeValue: ${dnm.value}');
  // }

  // updateString() async {
  //   final deneme = ref.child('deneme');
  //   final o = await deneme.child('1/name').get();
  //   final n = await deneme.child('0/name').get();
  //   if (o.exists && n.exists) {
  //     _string1.value = o.value as String;
  //     _string2.value = n.value as String;
  //     update();
  //     deneme.child('0').update({'name': o.value});
  //     deneme.child('1').update({'name': n.value});
  //   } else {
  //     log('data not available');
  //   }
  // }

//    Stream _getData(){
//   final deneme = ref.child('deneme');
//   deneme.onValue.listen((event) {
//     final String string = event.snapshot.;
//    });
// }

}
