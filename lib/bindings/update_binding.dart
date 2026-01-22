import 'package:get/get.dart';
import 'package:simple_learning_tracker/controllers/update_controller.dart';

class UpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateController>(() => UpdateController());
  }
}