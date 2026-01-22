import 'package:get/get.dart';
import 'package:simple_learning_tracker/bindings/create_bindings.dart';
import 'package:simple_learning_tracker/bindings/home_bindings.dart';
import 'package:simple_learning_tracker/pages/create_pages.dart';
import 'package:simple_learning_tracker/pages/homePage.dart';
import 'package:simple_learning_tracker/routes/routes.dart';
import 'package:simple_learning_tracker/bindings/update_binding.dart';
import 'package:simple_learning_tracker/pages/update_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.createPage,
      page: () => CreatePage(),
      binding: CreateBinding(),
    ),

    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      binding: HomeBindings(),
    ),

    GetPage(
      name: AppRoutes.updatePage,
      page: () => UpdatePage(),
      binding: UpdateBinding(),
    ),
  ];
}