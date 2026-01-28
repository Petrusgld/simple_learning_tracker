import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_learning_tracker/components/custom_spacing.dart';
import 'package:simple_learning_tracker/controllers/controller_homepage.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String _formatDate() {
    return DateFormat('dd MMM yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final scale = width / 375;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //header
            Container(
              padding: EdgeInsets.fromLTRB(20 * scale, 12 * scale, 20 * scale, 12 * scale),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10 * scale,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Text(
                        _getGreeting(),
                        style: TextStyle(
                          fontSize: 14 * scale,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(Icons.history, size: 22 * scale),
                        onPressed: () => controller.navigateToHistory(),
                      ),
                    ],
                  ),

                  Text(
                    'Hello, Matthew!',
                    style: TextStyle(
                      fontSize: 24 * scale,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2B3674),
                    ),
                  ),

                  const SizedBox(height: 6),

                  //count task
                  Obx(
                    () => RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14 * scale,
                          color: Colors.grey[700],
                        ),
                        children: [
                          const TextSpan(text: 'You have '),
                          TextSpan(
                            text: '${controller.learningList.length}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4318FF),
                              fontSize: 16 * scale,
                            ),
                          ),
                          TextSpan(
                            text: controller.learningList.length == 1
                                ? ' task today'
                                : ' tasks today',
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),

            //task list
            Expanded(
              child: Obx(
                () {
                  if (controller.isloading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.learningList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_outlined,
                            size: 80 * scale,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 12 * scale),
                          Text(
                            "Belum ada task",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8 * scale),
                          Text(
                            "Tap tombol + untuk menambah task baru",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14 * scale,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
                    itemCount: controller.learningList.length,
                    itemBuilder: (context, index) {
                      final item = controller.learningList[index];

                      // Get color based on priority - sesuai dengan CreateController
                      Color cardColor = controller.getPriorityColor(item.priority);

                      return Container(
                        margin: EdgeInsets.only(bottom: 12 * scale),
                        padding: EdgeInsets.all(18 * scale),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16 * scale),
                          boxShadow: [
                            BoxShadow(
                              color: cardColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // TITLE + PRIORITY BADGE + MENU
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.subject,
                                        style: TextStyle(
                                          fontSize: 19 * scale,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (item.priority != null) ...[
                                        SizedBox(height: 6 * scale),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10 * scale,
                                            vertical: 4 * scale,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            item.priority!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12 * scale,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),

                                PopupMenuButton(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (context) => [

                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, size: 18 * scale),
                                          SizedBox(width: 8 * scale),
                                          Text("Edit"),
                                        ],
                                      ),
                                      onTap: () => Future.microtask(
                                        () => controller.editItem(item),
                                      ),
                                    ),

                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle, size: 18 * scale, color: Colors.green),
                                          SizedBox(width: 8 * scale),
                                          Text("Mark Complete"),
                                        ],
                                      ),
                                      onTap: () => Future.microtask(
                                        () => controller.markAsCompleted(item),
                                      ),
                                    ),

                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, size: 18 * scale, color: Colors.red),
                                          SizedBox(width: 8 * scale),
                                          Text("Delete"),
                                        ],
                                      ),
                                      onTap: () => Future.microtask(
                                        () => controller.deleteItem(
                                          item.id,
                                          item.subject,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            CustomSpacing(height: 12 * scale),

                            //description
                            if (item.description != null && item.description!.isNotEmpty) ...[
                              Text(
                                item.description!,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14 * scale,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 12 * scale),
                            ],

                            // DATE AND TIME INFO
                            Row(
                              children: [
                                if (item.dueDate != null && item.dueDate!.isNotEmpty) ...[
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.white70,
                                    size: 14 * scale,
                                  ),
                                  SizedBox(width: 6 * scale),
                                  Text(
                                    item.dueDate!,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 16 * scale),
                                ],
                                
                                if (item.startTime != null && item.startTime!.isNotEmpty) ...[
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white70,
                                    size: 14 * scale,
                                  ),
                                  SizedBox(width: 6 * scale),
                                  Text(
                                    '${item.startTime} - ${item.endTime ?? ""}',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13 * scale,
                                    ),
                                  ),
                                ],
                              ],
                            ),

                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //fab
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.navigateToCreatePage(),
        backgroundColor: const Color(0xFF4318FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}