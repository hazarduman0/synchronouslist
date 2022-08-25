import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synchronouslistscrolling/bindings/await_bindings.dart';
import 'package:synchronouslistscrolling/ui/screens/mainpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //options: DefaultFirebaseOptions.currentPlatform,);
  await AwaitBindings().dependencies();
  

  // FirebaseDatabase.instance.setPersistenceEnabled(true);
  // final ref = FirebaseDatabase.instance.ref("");
  // ref.keepSynced(true);
  // FirebaseApp synchronouslis = Firebase.app('synchronouslis');
  // FirebaseDatabase database = FirebaseDatabase.instanceFor(app: synchronouslis);
  // database.setPersistenceEnabled(true);
  // database.setPersistenceCacheSizeBytes(10000000);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Synclist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
