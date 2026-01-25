import 'package:get/get.dart';
import 'package:simple_learning_tracker/controllers/controller_homepage.dart';


class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}