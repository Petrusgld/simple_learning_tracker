import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_learning_tracker/components/button_component.dart';
import 'package:simple_learning_tracker/components/color/custom_color.dart';
import 'package:simple_learning_tracker/components/customtext_component.dart';
import 'package:simple_learning_tracker/components/customtextfield2_component.dart';
import 'package:simple_learning_tracker/components/space_component.dart';
import 'package:simple_learning_tracker/controllers/update_controller.dart';
import 'package:simple_learning_tracker/model/models/learning_model.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({super.key});

  final UpdateController updateController = Get.put(
    UpdateController(),
    permanent: false,
  );

  // Ambil data yang dikirim dari halaman sebelumnya
  final LearningModel learningData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // Set data ke controller (run once)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateController.setInitialData(learningData);
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MainColor.backgroundColor.withOpacity(0.2),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                      Get.delete<UpdateController>();
                    },
                    icon: Icon(Icons.arrow_back, color: MainColor.mainColor),
                  ),
                ),
                const CustomText(
                  text: "Update Task",
                  color: MainColor.mainColor,
                  weight: FontWeight.bold,
                  size: 36,
                ),
              ],
            ),

            const SpacingComponent(height: 40),

            // Form
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    const CustomText(
                      text: "Title",
                      color: MainColor.textColor2,
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                    const SpacingComponent(height: 6),
                    CustomTextField2(
                      controller: updateController.titleEditingController,
                      hintText: "Enter task title...",
                      outlineColor: MainColor.grayColor,
                      borderRadius: 5,
                    ),

                    const SpacingComponent(height: 15),

                    // DESCRIPTION
                    const CustomText(
                      text: "Descriptions",
                      color: MainColor.textColor2,
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                    const SpacingComponent(height: 6),
                    CustomTextField2(
                      controller: updateController.descEditingController,
                      hintText: "Enter description task...",
                      outlineColor: MainColor.grayColor,
                      borderRadius: 5,
                    ),

                    const SpacingComponent(height: 15),

                    // DUE DATE
                    const CustomText(
                      text: "Due Date",
                      color: MainColor.textColor2,
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                    const SpacingComponent(height: 6),
                    CustomTextField2(
                      controller: updateController.dateEditingController,
                      readOnly: true,
                      hintText: "Select Date",
                      outlineColor: MainColor.grayColor,
                      borderRadius: 5,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => updateController.pickerDate(context),
                      ),
                    ),

                    const SpacingComponent(height: 15),

                    // START TIME & END TIME
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Start Time",
                                color: MainColor.textColor2,
                                weight: FontWeight.bold,
                                size: 18,
                              ),
                              const SpacingComponent(height: 5),
                              CustomTextField2(
                                controller:
                                    updateController.startTimeEditingController,
                                readOnly: true,
                                hintText: "Start",
                                outlineColor: MainColor.grayColor,
                                borderRadius: 5,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.access_time),
                                  onPressed: () =>
                                      updateController.spickerTime(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SpacingComponent(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "End Time",
                                color: MainColor.textColor2,
                                weight: FontWeight.bold,
                                size: 18,
                              ),
                              const SpacingComponent(height: 5),
                              CustomTextField2(
                                controller:
                                    updateController.endTimeEditingController,
                                readOnly: true,
                                hintText: "End",
                                outlineColor: MainColor.grayColor,
                                borderRadius: 5,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.access_time),
                                  onPressed: () =>
                                      updateController.epickerTime(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SpacingComponent(height: 15),
                    // PRIORITY
                    const CustomText(
                      text: "Priority",
                      color: MainColor.textColor2,
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                    const SpacingComponent(height: 10),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: updateController.listPriority.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => ButtonComponent(
                              weight: FontWeight.w600,
                              backgroundColor:
                                  updateController
                                      .listPriority[index]
                                      .priorityBool
                                      .value
                                  ? updateController.listPriority[index].color
                                  : Colors.transparent,
                              outlineColor:
                                  updateController.listPriority[index].color,
                              text: updateController
                                  .listPriority[index]
                                  .priorityText,
                              onPressed: () {
                                updateController.onHandle(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    const SpacingComponent(height: 20),
                  ],
                ),
              ),
            ),

            // UPDATE BUTTON
            // UPDATE BUTTON
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ButtonComponent(
                    height: 60,
                    width: 376,
                    backgroundColor: updateController.isLoading.value
                        ? MainColor.grayColor
                        : MainColor.mainColor,
                    text: updateController.isLoading.value
                        ? "Updating..."
                        : "Update Task",
                    size: 24,
                    weight: FontWeight.bold,
                    onPressed: () {
                      if (!updateController.isLoading.value) {
                        updateController.updateTask();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
