import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_learning_tracker/components/custom_spacing.dart';
import 'package:simple_learning_tracker/components/custom_textfield.dart';
import 'package:simple_learning_tracker/controllers/update_controller.dart';
import 'package:simple_learning_tracker/model/models/learning_model.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({super.key});

  final controller = Get.put(UpdateController());
  
  // Ambil data yang dikirim dari halaman sebelumnya
  final LearningModel learningData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // Set data ke controller
    controller.setInitialData(learningData);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Update Progress Belajar"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Edit Progress Belajar",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const CustomSpacing(height: 6),
              const Text(
                "Update target dan jam belajar kamu",
                style: TextStyle(color: Colors.grey),
              ),
              const CustomSpacing(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.subjectController,
                      label: "Mata Pelajaran",
                      icon: Icons.book,
                    ),
                    const CustomSpacing(height: 16),
                    CustomTextField(
                      controller: controller.targetController,
                      label: "Target Jam Belajar",
                      icon: Icons.flag,
                      keyboardType: TextInputType.number,
                    ),
                    const CustomSpacing(height: 16),
                    CustomTextField(
                      controller: controller.currentController,
                      label: "Jam Belajar Saat Ini",
                      icon: Icons.timer,
                      keyboardType: TextInputType.number,
                    ),
                    const CustomSpacing(height: 25),
                    // Tombol Update
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  if (controller.subjectController.text.isEmpty ||
                                      controller.targetController.text.isEmpty ||
                                      controller.currentController.text.isEmpty) {
                                    Get.snackbar(
                                      "Warning",
                                      "Semua field wajib diisi",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.orange,
                                      colorText: Colors.white,
                                    );
                                    return;
                                  }

                                  controller.updateLearning(
                                    learningData.id,
                                    controller.subjectController.text,
                                    controller.targetController.text,
                                    controller.currentController.text,
                                    learningData.createdAt,
                                  );
                                },
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Update Progress",
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}