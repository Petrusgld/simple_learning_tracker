import 'package:get/get.dart';
import 'package:simple_learning_tracker/controllers/create_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateController>(() =>  CreateController(),);
  }
}