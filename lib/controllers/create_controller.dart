import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
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

class CreateController extends GetxController {

  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref("tasks");

  //controllers

  final titleEditingController = TextEditingController();
  final descEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final startTimeEditingController = TextEditingController();
  final endTimeEditingController = TextEditingController();
  final targetHourEditingController = TextEditingController();
  final currentHourEditingController = TextEditingController();

  //state

  RxString dueDate = "".obs;
  RxString startTimer = "".obs;
  RxString endTimer = "".obs;

  RxBool isEdit = false.obs;
  String? editId;

  //priority list

  List<PriorityModel> listPriority = [
    PriorityModel(
        priorityText: "Activity",
        color: MainColor.accentColor,
        priorityBool: false.obs),
    PriorityModel(
        priorityText: "Study",
        color: MainColor.secondaryColor,
        priorityBool: false.obs),
    PriorityModel(
        priorityText: "Personal",
        color: MainColor.mainColor,
        priorityBool: false.obs),
  ];

  //init edit

  void initEdit(String? id) {
    clearForm();

    if (id != null) {
      isEdit.value = true;
      editId = id;

      loadTask(id);
    }
  }

  //load task for edit

  Future<void> loadTask(String id) async {
    final snapshot = await dbRef.child(id).get();

    if (snapshot.exists) {
      final data = snapshot.value as Map;

      titleEditingController.text = data['title'] ?? "";
      descEditingController.text = data['desc'] ?? "";

      dueDate.value = data['date'] ?? "";
      startTimer.value = data['start'] ?? "";
      endTimer.value = data['end'] ?? "";

      dateEditingController.text = dueDate.value;
      startTimeEditingController.text = startTimer.value;
      endTimeEditingController.text = endTimer.value;

      targetHourEditingController.text = data['targetHour'] ?? "0";
      currentHourEditingController.text = data['currentHour'] ?? "0";

      String priority = data['priority'] ?? "";

      for (var item in listPriority) {
        item.priorityBool.value =
            item.priorityText == priority;
      }
    }
  }

  //ui Text

  String getHeaderText() =>
      isEdit.value ? "Edit Task" : "Add Task";

  String getButtonText() =>
      isEdit.value ? "Update" : "Add Task";

  //picker

  Future<void> pickerDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dueDate.value =
          "${picked.year}-${picked.month}-${picked.day}";
      dateEditingController.text = dueDate.value;
    }
  }

  Future<void> spickerTime(BuildContext context) async {
    TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null) {
      startTimer.value = picked.format(context);
      startTimeEditingController.text = startTimer.value;
    }
  }

  Future<void> epickerTime(BuildContext context) async {
    TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (picked != null) {
      endTimer.value = picked.format(context);
      endTimeEditingController.text = endTimer.value;
    }
  }

  //priority handler

  void onHandle(int index) {
    for (var item in listPriority) {
      item.priorityBool.value = false;
    }

    listPriority[index].priorityBool.value = true;
  }

  String getSelectedPriority() {
    for (var item in listPriority) {
      if (item.priorityBool.value) {
        return item.priorityText;
      }
    }
    return "Low";
  }

  //Save

  Future<void> saveTask() async {

    if (titleEditingController.text.isEmpty) {
      Get.snackbar("Error", "Title cannot be empty");
      return;
    }

    final data = {
      "title": titleEditingController.text,
      "desc": descEditingController.text,
      "date": dueDate.value,
      "start": startTimer.value,
      "end": endTimer.value,
      "priority": getSelectedPriority(),
      "targetHour": targetHourEditingController.text.isEmpty ? "0" : targetHourEditingController.text,
      "currentHour": currentHourEditingController.text.isEmpty ? "0" : currentHourEditingController.text,
      "createdAt": DateTime.now().toIso8601String(),
    };

    try {
      if (isEdit.value && editId != null) {
        await dbRef.child(editId!).update(data);
      } else {
        await dbRef.push().set(data);
      }

      Get.back();
      clearForm();

      Get.snackbar("Success", "Task saved successfully");

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  //clear form

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

    isEdit.value = false;
    editId = null;
  }

  //text

  String sTimer() =>
      startTimer.value.isEmpty ? "Select Time" : startTimer.value;

  String eTimer() =>
      endTimer.value.isEmpty ? "Select Time" : endTimer.value;
}