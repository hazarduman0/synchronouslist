import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synchronouslistscrolling/controller/reorderablelistview_controller.dart';

class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();

  final ReorderableListViewController _rc = Get.find();

  DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarBuild(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.03, horizontal: Get.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 3,
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text('Kelime Ekle',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const Spacer(),
                          TextFormField(
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Bu alan boş bırakılmamalı';
                              }
                            },
                            onSaved: (newValue) async {
                              _rc.addTempStringList(newValue!);
                              await _database.child('itemList').push().set({
                                'name': newValue,
                              });
                            },
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder()),
                          ),
                          const Spacer(),
                          SizedBox(
                              height: Get.height * 0.06,
                              width: Get.width / 2,
                              child: ElevatedButton(
                                  onPressed: () {
                                    validateAndSave();
                                  },
                                  child: const Text('Ekle',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold))))
                        ],
                      ),
                    )),
                SizedBox(height: Get.height * 0.04),
                Expanded(
                    flex: 6,
                    child: GetBuilder<ReorderableListViewController>(
                        builder: (rc) {
                      return rc.addedWords.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Eklenen Kelimeler',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    itemCount: rc.addedWords.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: Text(
                                            '+${rc.addedWords[index]}',
                                            style: const TextStyle(
                                                fontSize: 20.0)),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink();
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateAndSave() {
    final isValid = _key.currentState!.validate();
    if (isValid) {
      _key.currentState!.save();
      Get.snackbar('Başarılı', 'Kelime Eklendi');
    }
  }

  AppBar _appbarBuild() {
    return AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              _rc.resetTempStringList();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.black, size: 30.0)));
  }
}
