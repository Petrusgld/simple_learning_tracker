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
    // Init edit data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addEditTaskController.initEdit(taskId);
    });

    final width = MediaQuery.of(context).size.width;
    final scale = width / 375;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16 * scale, right: 16 * scale, top: 50 * scale),
        child: Column(
          children: [
            //Headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45 * scale,
                  height: 45 * scale,
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
                    size: 36 * scale,
                  ),
                ),
              ],
            ),

            SpacingComponent(height: 40 * scale),

            //form
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    CustomText(
                      text: "Title",
                      color: MainColor.textColor2,
                      weight: FontWeight.bold,
                      size: 18 * scale,
                    ),

                     SpacingComponent(height: 6 * scale),

                    CustomTextField2(
                      controller:
                          addEditTaskController.titleEditingController,
                      hintText: "Enter task title...",
                      outlineColor: MainColor.grayColor,
                      borderRadius: 5 * scale,
                    ),

                    SpacingComponent(height: 15 * scale),

                    CustomText(
                      text: "Descriptions",
                      color: MainColor.textColor2,
                      weight: FontWeight.bold,
                      size: 18 * scale,
                    ),

                    SpacingComponent(height: 6 * scale),

                    CustomTextField2(
                      controller: addEditTaskController.descEditingController,
                      hintText: "Enter description task...",
                      outlineColor: MainColor.grayColor,
                      borderRadius: 5 * scale,
                    ),

                    SpacingComponent(height: 15 * scale),

                    CustomText(
                      text: "Due Date",
                      color: MainColor.textColor2,
                      weight: FontWeight.bold,
                      size: 18 * scale,
                    ),

                    SpacingComponent(height: 6 * scale),

                    CustomTextField2(
                      controller:
                          addEditTaskController.dateEditingController,
                      readOnly: true,
                      hintText: "Select Date",
                      outlineColor: MainColor.grayColor,
                      borderRadius: 5 * scale,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () =>
                            addEditTaskController.pickerDate(context),
                      ),
                    ),

                    SpacingComponent(height: 15 * scale),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Start Time",
                                color: MainColor.textColor2,
                                weight: FontWeight.bold,
                                size: 18 * scale,
                              ),
                              SpacingComponent(height: 5 * scale),

                              CustomTextField2(
                                controller: addEditTaskController
                                    .startTimeEditingController,
                                readOnly: true,
                                hintText: "Start",
                                outlineColor: MainColor.grayColor,
                                borderRadius: 5 * scale,
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

                        SpacingComponent(width: 10 * scale),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "End Time",
                                color: MainColor.textColor2,
                                weight: FontWeight.bold,
                                size: 18 * scale,
                              ),
                              SpacingComponent(height: 5 * scale),

                              CustomTextField2(
                                controller: addEditTaskController
                                    .endTimeEditingController,
                                readOnly: true,
                                hintText: "End",
                                outlineColor: MainColor.grayColor,
                                borderRadius: 5 * scale,
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

                    SpacingComponent(height: 20 * scale),

                    CustomText(
                      text: "Priority",
                      color: MainColor.textColor2,
                      weight: FontWeight.bold,
                      size: 18 * scale,
                    ),

                    SpacingComponent(height: 10 * scale),

                    SizedBox(
                      height: 40 * scale,
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

                    SpacingComponent(height: 20 * scale),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 28 * scale),
              child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ButtonComponent(
                    height: 60 * scale,
                    width: 376 * scale,
                    backgroundColor: MainColor.mainColor,
                    text: addEditTaskController.getButtonText(),
                    size: 24 * scale,
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