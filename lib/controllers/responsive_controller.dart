import 'package:get/get.dart';

class ResponsiveController extends GetxController {

  var screenWidth = 375.0.obs;

  void setScreenWidth(double width) {
    screenWidth.value = width;
  }

  double scale(double value) {
    return value * (screenWidth.value / 375);
  }
}
