import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:simple_learning_tracker/model/models/learning_model.dart';
import 'package:simple_learning_tracker/routes/routes.dart';
import 'package:simple_learning_tracker/components/color/custom_color.dart';

class HomeController extends GetxController {

  // Ubah reference database ke 'tasks' untuk mengambil data dari CreateController
  final dbRef = FirebaseDatabase.instance.ref("tasks");
  final historyRef = FirebaseDatabase.instance.ref("learning_history");

  // ================= STATE =================

  RxBool isloading = true.obs;

  RxList<LearningModel> learningList = <LearningModel>[].obs;

  // ================= INIT =================

  @override
  void onInit() {
    super.onInit();
    fetchLearningRealtime();
  }

  // ================= FETCH REALTIME =================

  void fetchLearningRealtime() {
    dbRef.onValue.listen((event) {

      learningList.clear();

      if (event.snapshot.exists) {

        for (var item in event.snapshot.children) {
          learningList.add(
            LearningModel.fromRealtime(item),
          );
        }
      }

      isloading.value = false;
    });
  }

  // ================= GET COLOR BY PRIORITY =================
  // Sesuai dengan warna di CreateController
  Color getPriorityColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'activity':
        return MainColor.accentColor; // #3C6997
      case 'study':
        return MainColor.secondaryColor; // #33A1E0
      case 'personal':
        return MainColor.mainColor; // #094074
      default:
        return const Color(0xFF2B3674); // Default color
    }
  }

  // ================= COMPLETE TASK =================

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

          // SAVE TO HISTORY
          await historyRef.push().set({
            'subject': item.subject,
            'targetHour': item.targetHour,
            'currentHour': item.currentHour,
            'createdAt': item.createdAt,
            'completedAt': DateTime.now().toIso8601String(),
          });

          // DELETE FROM ACTIVE LIST
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

  // ================= DELETE =================

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

  // ================= NAVIGATION =================

  void editItem(LearningModel item) {
    Get.toNamed(
      AppRoutes.createPage,
      arguments: item.id,
    );
  }

  void navigateToCreatePage() {
    Get.toNamed(AppRoutes.createPage);
  }

  void navigateToHistory() {
    Get.toNamed(AppRoutes.historyPage);
  }
}