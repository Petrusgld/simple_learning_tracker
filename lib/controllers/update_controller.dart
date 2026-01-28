import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:simple_learning_tracker/model/models/learning_model.dart';
import 'package:simple_learning_tracker/components/color/custom_color.dart';

class PriorityModel {
  String priorityText;
  Color color;
  RxBool priorityBool;

  PriorityModel({
    required this.priorityText,
    required this.color,
    required this.priorityBool,
  });
}

class UpdateController extends GetxController {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref("tasks");

  // Controllers
  final titleEditingController = TextEditingController();
  final descEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final startTimeEditingController = TextEditingController();
  final endTimeEditingController = TextEditingController();
  final targetHourEditingController = TextEditingController();
  final currentHourEditingController = TextEditingController();

  // State
  RxString dueDate = "".obs;
  RxString startTimer = "".obs;
  RxString endTimer = "".obs;
  RxBool isLoading = false.obs;

  String? editId;

  // Priority list - sama seperti CreateController
  List<PriorityModel> listPriority = [
    PriorityModel(
      priorityText: "Activity",
      color: MainColor.accentColor,
      priorityBool: false.obs,
    ),
    PriorityModel(
      priorityText: "Study",
      color: MainColor.secondaryColor,
      priorityBool: false.obs,
    ),
    PriorityModel(
      priorityText: "Personal",
      color: MainColor.mainColor,
      priorityBool: false.obs,
    ),
  ];

  // Set data awal dari data yang akan diupdate
  void setInitialData(LearningModel data) {
    editId = data.id;
    
    titleEditingController.text = data.subject;
    descEditingController.text = data.description ?? '';
    
    dueDate.value = data.dueDate ?? '';
    startTimer.value = data.startTime ?? '';
    endTimer.value = data.endTime ?? '';
    
    dateEditingController.text = dueDate.value;
    startTimeEditingController.text = startTimer.value;
    endTimeEditingController.text = endTimer.value;
    
    targetHourEditingController.text = data.targetHour;
    currentHourEditingController.text = data.currentHour;

    // Set priority
    String priority = data.priority ?? "";
    for (var item in listPriority) {
      item.priorityBool.value = item.priorityText == priority;
    }
  }

  // Picker Date
  Future<void> pickerDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dueDate.value = "${picked.year}-${picked.month}-${picked.day}";
      dateEditingController.text = dueDate.value;
    }
  }

  // Start Time Picker
  Future<void> spickerTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      startTimer.value = picked.format(context);
      startTimeEditingController.text = startTimer.value;
    }
  }

  // End Time Picker
  Future<void> epickerTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      endTimer.value = picked.format(context);
      endTimeEditingController.text = endTimer.value;
    }
  }

  // Priority handler
  void onHandle(int index) {
    for (var item in listPriority) {
      item.priorityBool.value = false;
    }
    listPriority[index].priorityBool.value = true;
  }

  // Get selected priority
  String getSelectedPriority() {
    for (var item in listPriority) {
      if (item.priorityBool.value) {
        return item.priorityText;
      }
    }
    return "Activity"; // Default
  }

  // Update Task
  Future<void> updateTask() async {
    if (titleEditingController.text.isEmpty) {
      Get.snackbar("Error", "Title cannot be empty");
      return;
    }

    if (editId == null) {
      Get.snackbar("Error", "Invalid task ID");
      return;
    }

    try {
      isLoading.value = true;

      final data = {
        "title": titleEditingController.text,
        "desc": descEditingController.text,
        "date": dueDate.value,
        "start": startTimer.value,
        "end": endTimer.value,
        "priority": getSelectedPriority(),
        "targetHour": targetHourEditingController.text.isEmpty
            ? "0"
            : targetHourEditingController.text,
        "currentHour": currentHourEditingController.text.isEmpty
            ? "0"
            : currentHourEditingController.text,
      };

      await dbRef.child(editId!).update(data);

      Get.back();

      Get.snackbar(
        "Success",
        "Task updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update task: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Clear form
  void clearForm() {
    titleEditingController.clear();
    descEditingController.clear();
    dateEditingController.clear();
    startTimeEditingController.clear();
    endTimeEditingController.clear();
    targetHourEditingController.clear();
    currentHourEditingController.clear();

    dueDate.value = "";
    startTimer.value = "";
    endTimer.value = "";

    for (var item in listPriority) {
      item.priorityBool.value = false;
    }

    editId = null;
  }

  @override
  void onClose() {
    titleEditingController.dispose();
    descEditingController.dispose();
    dateEditingController.dispose();
    startTimeEditingController.dispose();
    endTimeEditingController.dispose();
    targetHourEditingController.dispose();
    currentHourEditingController.dispose();
    super.onClose();
  }
}