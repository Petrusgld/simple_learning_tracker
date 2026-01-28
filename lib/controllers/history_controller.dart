import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:simple_learning_tracker/model/models/history_model.dart';

class HistoryController extends GetxController {
  final dbRef = FirebaseDatabase.instance.ref("learning_history");
  
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;
  RxBool isLoading = true.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchHistoryData();
  }

  void fetchHistoryData() {
    dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        final list = data.entries.map((e) {
          return HistoryModel.fromMap(e.key, e.value as Map);
        }).toList();
        
        list.sort((a, b) => b.completedAt.compareTo(a.completedAt));
        
        historyList.value = list;
      } else {
        historyList.value = [];
      }
      isLoading.value = false;
    });
  }

  void deleteHistoryItem(String id, String subject) {
    Get.defaultDialog(
      title: "Konfirmasi Hapus",
      middleText: "Yakin ingin menghapus history \"$subject\"?",
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
            "History berhasil dihapus",
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

  void clearAllHistory() {
    Get.defaultDialog(
      title: "Konfirmasi",
      middleText: "Yakin ingin menghapus semua history?",
      textConfirm: "Hapus Semua",
      textCancel: "Batal",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        try {
          await dbRef.remove();
          Get.back();
          Get.snackbar(
            "Success",
            "Semua history berhasil dihapus",
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
}