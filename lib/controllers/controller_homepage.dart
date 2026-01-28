import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:simple_learning_tracker/model/models/learning_model.dart';
import 'package:simple_learning_tracker/routes/routes.dart';

class HomeController extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref("learning_tracker");
  final historyRef = FirebaseDatabase.instance.ref("learning_history");
  
  RxList<LearningModel> learningList = <LearningModel>[].obs;
  RxBool isLoading = true.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        final list = data.entries.map((e) {
          return LearningModel.fromMap(e.key, e.value as Map);
        }).toList();
        learningList.value = list;
      } else {
        learningList.value = [];
      }
      isLoading.value = false;
    });
  }

  void markAsCompleted(LearningModel item) {
    Get.defaultDialog(
      title: "Konfirmasi",
      middleText: "Tandai \"${item.subject}\" sebagai selesai?",
      textConfirm: "Ya",
      textCancel: "Batal",
      confirmTextColor: Colors.white,
      buttonColor: Colors.green,
      onConfirm: () async {
        try {
          // Pindahkan ke history
          await historyRef.push().set({
            'subject': item.subject,
            'targetHour': item.targetHour,
            'currentHour': item.currentHour,
            'createdAt': item.createdAt,
            'completedAt': DateTime.now().toString(),
          });

          // Hapus dari learning tracker
          await dbRef.child(item.id).remove();

          Get.back();
          Get.snackbar(
            "Success",
            "Task berhasil diselesaikan!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            icon: const Icon(Icons.check_circle, color: Colors.white),
          );
        } catch (e) {
          Get.back();
          Get.snackbar(
            "Error",
            "Gagal menyelesaikan task: $e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
    );
  }

  void deleteItem(String id, String subject) {
    Get.defaultDialog(
      title: "Konfirmasi Hapus",
      middleText: "Yakin ingin menghapus \"$subject\"?",
      textConfirm: "Hapus",
      textCancel: "Batal",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        try {
          await dbRef.child(id).remove();
          Get.back();
          Get.snackbar(
            "Success",
            "Data berhasil dihapus",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } catch (e) {
          Get.back();
          Get.snackbar(
            "Error",
            "Gagal menghapus: $e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
    );
  }

  void editItem(LearningModel item) {
    Get.toNamed(AppRoutes.updatePage, arguments: item);
  }

  void navigateToCreatePage() {
    Get.toNamed(AppRoutes.createPage);
  }

  void navigateToHistory() {
    Get.toNamed(AppRoutes.historyPage);
  }
}