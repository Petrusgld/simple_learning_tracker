// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:simple_learning_tracker/model/models/learning_model.dart';
// import 'package:simple_learning_tracker/routes/routes.dart';

// class HomeController extends GetxController {
//   final dbRef = FirebaseDatabase.instance.ref("learning_tracker");
  
//   RxList<LearningModel> learningList = <LearningModel>[].obs;
//   RxBool isLoading = true.obs;
  
//   @override
//   void onInit() {
//     super.onInit();
//     fetchData();
//   }

//   void fetchData() {
//     dbRef.onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>?;

//       if (data != null) {
//         final list = data.entries.map((e) {
//           return LearningModel.from(e.key, e.value as Map);
//         }).toList();
//         learningList.value = list;
//       } else {
//         learningList.value = [];
//       }
//       isLoading.value = false;
//     });
//   }

//   void deleteItem(String id, String subject) {
//     Get.defaultDialog(
//       title: "Konfirmasi Hapus",
//       middleText: "Yakin ingin menghapus \"$subject\"?",
//       textConfirm: "Hapus",
//       textCancel: "Batal",
//       confirmTextColor: Colors.white,
//       buttonColor: Colors.red,
//       onConfirm: () async {
//         try {
//           await dbRef.child(id).remove();
//           Get.back();
//           Get.snackbar(
//             "Success",
//             "Data berhasil dihapus",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//           );
//         } catch (e) {
//           Get.back();
//           Get.snackbar(
//             "Error",
//             "Gagal menghapus: $e",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//         }
//       },
//     );
//   }

//   void editItem(LearningModel item) {
//     Get.toNamed(AppRoutes.updatePage, arguments: item);
//   }

//   void navigateToCreatePage() {
//     Get.toNamed(AppRoutes.createPage);
//   }
// }