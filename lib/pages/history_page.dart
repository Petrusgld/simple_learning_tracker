import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_learning_tracker/controllers/history_controller.dart';
import 'package:simple_learning_tracker/components/color/custom_color.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      final year = date.year;
      final hour = date.hour.toString().padLeft(2, '0');
      final minute = date.minute.toString().padLeft(2, '0');
      return '$day/$month/$year, $hour:$minute';
    } catch (e) {
      return dateString;
    }
  }

  // Fungsi untuk mendapatkan warna sesuai priority
  // SAMA PERSIS dengan CreateController
  Color _getPriorityColor(String? priority) {
    if (priority == null) return MainColor.accentColor;
    
    switch (priority) {
      case 'Activity':
        return MainColor.accentColor;
      case 'Study':
        return MainColor.secondaryColor;
      case 'Personal':
        return MainColor.mainColor;
      default:
        return MainColor.accentColor; // untuk "Low" atau lainnya
    }
  }

  @override
  Widget build(BuildContext context) {
    final HistoryController controller = Get.find<HistoryController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.historyList.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header dengan tombol back untuk empty state
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color(0xFF1E3A5F),
                              ),
                              onPressed: () => Get.back(),
                              tooltip: "Kembali",
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                "Completed",
                                style: TextStyle(
                                  color: Color(0xFF1E3A5F),
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Empty state content
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.history,
                                size: 100,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Belum ada history",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Todo yang selesai akan muncul di sini",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header "Completed" dengan tombol back
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Row(
                          children: [
                            // Tombol back
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color(0xFF1E3A5F),
                              ),
                              onPressed: () => Get.back(),
                              tooltip: "Kembali",
                            ),
                            const SizedBox(width: 8),
                            // Title "Completed"
                            const Expanded(
                              child: Text(
                                "Completed",
                                style: TextStyle(
                                  color: Color(0xFF1E3A5F),
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Menu button
                            IconButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Color(0xFF1E3A5F),
                              ),
                              onPressed: () => controller.clearAllHistory(),
                              tooltip: "Hapus Semua",
                            ),
                          ],
                        ),
                      ),
                      // List of completed tasks
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: controller.historyList.length,
                          itemBuilder: (context, index) {
                            final item = controller.historyList[index];
                            // Ambil warna berdasarkan priority
                            final cardColor = _getPriorityColor(item.priority ?? 'Activity');

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title and menu button
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
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            // Priority badge
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
                                      PopupMenuButton<String>(
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                        onSelected: (value) {
                                          if (value == 'delete') {
                                            controller.deleteHistoryItem(
                                                item.id, item.subject);
                                          }
                                        },
                                        itemBuilder: (context) {
                                          return [
                                            const PopupMenuItem(
                                              value: 'delete',
                                              child: Text('Delete'),
                                            ),
                                          ];
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Subtitle (target and achieved hours)
                                  Text(
                                    'Target: ${item.targetHour} jam • Tercapai: ${item.currentHour} jam',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // Time with icon
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        _formatDate(item.completedAt),
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}