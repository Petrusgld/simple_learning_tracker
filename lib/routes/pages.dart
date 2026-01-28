import 'package:get/get.dart';
import 'package:simple_learning_tracker/bindings/create_bindings.dart';
import 'package:simple_learning_tracker/pages/create_pages.dart';
import 'package:simple_learning_tracker/routes/routes.dart';
import 'package:simple_learning_tracker/bindings/histoty_binding.dart';
import 'package:simple_learning_tracker/bindings/home_bindings.dart';
import 'package:simple_learning_tracker/pages/history_page.dart';
import 'package:simple_learning_tracker/pages/HomePage.dart';
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
      name: AppRoutes.historyPage,
      page: () => HistoryPage(),
      binding: HistoryBinding(),
    ),

      GetPage(
      name: AppRoutes.updatePage,
      page: () => UpdatePage(),
    ),
  ];
}
