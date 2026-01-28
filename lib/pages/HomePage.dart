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

                  const SizedBox(height: 12),

                  // FILTER CHIP UI ONLY
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All', true),
                        const SizedBox(width: 8),
                        _buildFilterChip('Today', false),
                        const SizedBox(width: 8),
                        _buildFilterChip('Upcoming', false),
                        const SizedBox(width: 8),
                        _buildFilterChip('Personal', false),
                      ],
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
                            Icons.school_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Belum ada progress belajar",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.learningList.length,
                    itemBuilder: (context, index) {
                      final item = controller.learningList[index];

                      final progress =
                          (double.tryParse(item.currentHour) ?? 0) /
                              (double.tryParse(item.targetHour) ?? 1);

                      Color cardColor;
                      if (index % 3 == 0) {
                        cardColor = const Color(0xFF4A5FE8);
                      } else if (index % 3 == 1) {
                        cardColor = const Color(0xFF00C2FF);
                      } else {
                        cardColor = const Color(0xFF2B3674);
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // TITLE + MENU
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.subject,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                PopupMenuButton(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (context) => [

                                    PopupMenuItem(
                                      child: const Text("Edit"),
                                      onTap: () => Future.microtask(
                                        () => controller.editItem(item),
                                      ),
                                    ),

                                    PopupMenuItem(
                                      child: const Text("Mark Complete"),
                                      onTap: () => Future.microtask(
                                        () => controller.markAsCompleted(item),
                                      ),
                                    ),

                                    PopupMenuItem(
                                      child: const Text("Delete"),
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

                            const SizedBox(height: 8),

                            Text(
                              '${item.currentHour}/${item.targetHour} Jam',
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),

                            const SizedBox(height: 10),

                            LinearProgressIndicator(
                              value: progress.clamp(0.0, 1.0),
                              backgroundColor:
                                  Colors.white.withOpacity(0.3),
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
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
        child: const Icon(Icons.add),
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
