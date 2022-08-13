import 'package:get/get.dart';
import 'package:synchronouslistscrolling/controller/reorderablelistview_controller.dart';

class AwaitBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    
    await Get.putAsync(() async => ReorderableListViewController(), permanent: true);
  }
}