import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_learning_tracker/components/custom_spacing.dart';
import 'package:simple_learning_tracker/components/custom_textfield.dart';
import 'package:simple_learning_tracker/controllers/create_controller.dart';

class CreatePage extends StatelessWidget {
  CreatePage({super.key});

  final controller = Get.put(CreateController());

  final subjectController = TextEditingController();
  final targetController = TextEditingController();
  final currentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(title: const Text(""), centerTitle: true, elevation: 0),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tambah Progress Belajar",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const CustomSpacing(height: 6),

              const Text(
                "Catat target dan jam belajar kamu hari ini",
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
                      controller: subjectController,
                      label: "Mata Pelajaran",
                      icon: Icons.book,
                    ),

                    const CustomSpacing(height: 16),

                    CustomTextField(
                      controller: targetController,
                      label: "Target Jam Belajar",
                      icon: Icons.flag,
                    ),

                    const CustomSpacing(height: 16),

                    CustomTextField(
                      controller: currentController,
                      label: "Jam Belajar Saat Ini",
                      icon: Icons.timer,
                    ),

                    const CustomSpacing(height: 25),

                    //save
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  if (subjectController.text.isEmpty ||
                                      targetController.text.isEmpty ||
                                      currentController.text.isEmpty) {
                                    Get.snackbar(
                                      "Warning",
                                      "Semua field wajib diisi",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                    return;
                                  }

                                  controller.addLearning(
                                    subjectController.text,
                                    targetController.text,
                                    currentController.text,
                                  );

                                  subjectController.clear();
                                  targetController.clear();
                                  currentController.clear();
                                },

                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Simpan Progress",
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
