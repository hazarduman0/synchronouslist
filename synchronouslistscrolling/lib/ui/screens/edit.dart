import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synchronouslistscrolling/controller/reorderablelistview_controller.dart';

class EditPage extends StatelessWidget {
  EditPage({Key? key, required this.id}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final ReorderableListViewController _rc = Get.find();

  DatabaseReference _database = FirebaseDatabase.instance.ref();

  String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarBuild(),
      body: SizedBox(
        height: Get.width,
        width: Get.width,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                  width: Get.width / 1.5,
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Güncelle',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                    width: Get.width / 1.5,
                    child: TextFormField(
                      initialValue: _rc.initialValue,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder()),
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bu alan boş bırakılmamalı';
                        }
                      },
                      onSaved: (newValue) async {
                        await _database
                            .child('itemList')
                            .child(id)
                            .update({'name': newValue});

                        Get.snackbar('Başarılı', 'Text güncellendi');    
                      },
                    )),
                SizedBox(height: Get.height * 0.1),
                SizedBox(
                  height: Get.height * 0.07,
                  width: Get.width / 2,
                  child: ElevatedButton(
                      onPressed: () {
                        validateAndUpdate();
                      },
                      child: const Text('Güncelle',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateAndUpdate() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  AppBar _appbarBuild() {
    return AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              _rc.setInitialValue('');
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                color: Colors.black, size: 30.0)));
  }
}
