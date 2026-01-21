import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:simple_learning_tracker/model/models/learning_model.dart';

class CreateController extends GetxController {

  final dbRef =
      FirebaseDatabase.instance.ref("learning_tracker");

  RxBool isLoading = false.obs;

  Future addLearning(
    String subject,
    String targetHour,
    String currentHour,
  ) async {

    try {
      isLoading.value = true;

      final data = LearningModel(
        id: "",
        subject: subject,
        targetHour: targetHour,
        currentHour: currentHour,
        createdAt: DateTime.now().toString(),
      );

      await dbRef.push().set(data.toMap());

      Get.snackbar(
        "Success",
        "Tracker berhasil disimpan",
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

    } finally {
      isLoading.value = false;
    }
  }
}
