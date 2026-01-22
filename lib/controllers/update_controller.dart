import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:simple_learning_tracker/model/models/learning_model.dart';

class UpdateController extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref("learning_tracker");

  RxBool isLoading = false.obs;

  final subjectController = TextEditingController();
  final targetController = TextEditingController();
  final currentController = TextEditingController();

  // Set data awal dari data yang akan diupdate
  void setInitialData(LearningModel data) {
    subjectController.text = data.subject;
    targetController.text = data.targetHour;
    currentController.text = data.currentHour;
  }

  // Fungsi untuk update data ke Firebase Realtime Database
  Future<void> updateLearning(
    String id,
    String subject,
    String targetHour,
    String currentHour,
    String createdAt,
  ) async {
    try {
      isLoading.value = true;

      // Update data ke Firebase
      await dbRef.child(id).update({
        'subject': subject,
        'targetHour': targetHour,
        'currentHour': currentHour,
        'createdAt': createdAt,
      });

      Get.snackbar(
        "Success",
        "Progress belajar berhasil diupdate",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Kembali ke halaman sebelumnya
      Get.back();
      
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal update data: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    subjectController.dispose();
    targetController.dispose();
    currentController.dispose();
    super.onClose();
  }
}