import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= HEADER =================
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
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
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.history, size: 22),
                        onPressed: () => controller.navigateToHistory(),
                      ),
                    ],
                  ),

                  const Text(
                    'Hello, Matthew!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2B3674),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // COUNT TASK REACTIVE
                  Obx(
                    () => RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        children: [
                          const TextSpan(text: 'You have '),
                          TextSpan(
                            text: '${controller.learningList.length}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4318FF),
                              fontSize: 16,
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

            // ================= TASK LIST =================
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
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Belum ada task",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Tap tombol + untuk menambah task baru",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    itemCount: controller.learningList.length,
                    itemBuilder: (context, index) {
                      final item = controller.learningList[index];

                      // Get color based on priority - sesuai dengan CreateController
                      Color cardColor = controller.getPriorityColor(item.priority);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
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
                                        style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      if (item.priority != null) ...[
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            item.priority!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
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
                                      child: const Row(
                                        children: [
                                          Icon(Icons.edit, size: 18),
                                          SizedBox(width: 8),
                                          Text("Edit"),
                                        ],
                                      ),
                                      onTap: () => Future.microtask(
                                        () => controller.editItem(item),
                                      ),
                                    ),

                                    PopupMenuItem(
                                      child: const Row(
                                        children: [
                                          Icon(Icons.check_circle, size: 18, color: Colors.green),
                                          SizedBox(width: 8),
                                          Text("Mark Complete"),
                                        ],
                                      ),
                                      onTap: () => Future.microtask(
                                        () => controller.markAsCompleted(item),
                                      ),
                                    ),

                                    PopupMenuItem(
                                      child: const Row(
                                        children: [
                                          Icon(Icons.delete, size: 18, color: Colors.red),
                                          SizedBox(width: 8),
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

                            const SizedBox(height: 12),

                            // DESCRIPTION (if available)
                            if (item.description != null && item.description!.isNotEmpty) ...[
                              Text(
                                item.description!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                            ],

                            // DATE AND TIME INFO
                            Row(
                              children: [
                                if (item.dueDate != null && item.dueDate!.isNotEmpty) ...[
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white70,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    item.dueDate!,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                                
                                if (item.startTime != null && item.startTime!.isNotEmpty) ...[
                                  const Icon(
                                    Icons.access_time,
                                    color: Colors.white70,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${item.startTime} - ${item.endTime ?? ""}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
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

      // ================= FAB =================
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.navigateToCreatePage(),
        backgroundColor: const Color(0xFF4318FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4318FF) : Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[700],
          fontWeight:
              isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }
}