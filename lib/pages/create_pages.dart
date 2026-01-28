import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_learning_tracker/components/button_component.dart';
import 'package:simple_learning_tracker/components/color/custom_color.dart';
import 'package:simple_learning_tracker/components/customtext_component.dart';
import 'package:simple_learning_tracker/components/customtextfield2_component.dart';
import 'package:simple_learning_tracker/components/space_component.dart';
import 'package:simple_learning_tracker/controllers/create_controller.dart';

class CreatePage extends StatelessWidget {
  CreatePage({super.key, this.taskId});

  final String? taskId;

  final CreateController addEditTaskController = Get.put(
    CreateController(),
    permanent: false,
  );

  @override
  Widget build(BuildContext context) {
    // Init edit data (run once)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addEditTaskController.initEdit(taskId);
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
        child: Column(
          children: [
            //Headers
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
                      Get.delete<CreateController>();
                    },
                    icon: Icon(Icons.arrow_back, color: MainColor.mainColor),
                  ),
                ),
                Obx(
                  () => CustomText(
                    text: addEditTaskController.getHeaderText(),
                    color: MainColor.mainColor,
                    weight: FontWeight.bold,
                    size: 36,
                  ),
                ),
              ],
            ),

            const SpacingComponent(height: 40),

            //form
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
                      controller:
                          addEditTaskController.titleEditingController,
                      hintText: "Enter task title...",
                      outlineColor: MainColor.grayColor,
                      borderRadius: 5,
                    ),

                    const SpacingComponent(height: 15),

                    const CustomText(
                      text: "Descriptions",
                      color: MainColor.textColor2,
                      weight: FontWeight.bold,
                      size: 18,
                    ),

                    const SpacingComponent(height: 6),

                    CustomTextField2(
                      controller: addEditTaskController.descEditingController,
                      hintText: "Enter description task...",
                      outlineColor: MainColor.grayColor,
                      borderRadius: 5,
                    ),

                    const SpacingComponent(height: 15),

                    const CustomText(
                      text: "Due Date",
                      color: MainColor.textColor2,
                      weight: FontWeight.bold,
                      size: 18,
                    ),

                    const SpacingComponent(height: 6),

                    CustomTextField2(
                      controller:
                          addEditTaskController.dateEditingController,
                      readOnly: true,
                      hintText: "Select Date",
                      outlineColor: MainColor.grayColor,
                      borderRadius: 5,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () =>
                            addEditTaskController.pickerDate(context),
                      ),
                    ),

                    const SpacingComponent(height: 15), 
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
                                controller: addEditTaskController
                                    .startTimeEditingController,
                                readOnly: true,
                                hintText: "Start",
                                outlineColor: MainColor.grayColor,
                                borderRadius: 5,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.access_time),
                                  onPressed: () =>
                                      addEditTaskController.spickerTime(
                                          context),
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
                                controller: addEditTaskController
                                    .endTimeEditingController,
                                readOnly: true,
                                hintText: "End",
                                outlineColor: MainColor.grayColor,
                                borderRadius: 5,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.access_time),
                                  onPressed: () =>
                                      addEditTaskController.epickerTime(
                                          context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SpacingComponent(height: 20),

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
                        itemCount:
                            addEditTaskController.listPriority.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => ButtonComponent(
                              weight: FontWeight.w600,
                              backgroundColor:
                                  addEditTaskController
                                          .listPriority[index]
                                          .priorityBool
                                          .value
                                      ? addEditTaskController
                                          .listPriority[index]
                                          .color
                                      : Colors.transparent,
                              outlineColor: addEditTaskController
                                  .listPriority[index].color,
                              text: addEditTaskController
                                  .listPriority[index].priorityText,
                              onPressed: () {
                                addEditTaskController.onHandle(index);
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
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ButtonComponent(
                    height: 60,
                    width: 376,
                    backgroundColor: MainColor.mainColor,
                    text: addEditTaskController.getButtonText(),
                    size: 24,
                    weight: FontWeight.bold,
                    onPressed: () {
                      addEditTaskController.saveTask();
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