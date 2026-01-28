import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_learning_tracker/controllers/history_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    final HistoryController controller = Get.find<HistoryController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          Obx(() {
            if (controller.historyList.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.delete_sweep),
                onPressed: () => controller.clearAllHistory(),
                tooltip: "Hapus Semua",
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.historyList.isEmpty
                ? Center(
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
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.historyList.length,
                    itemBuilder: (context, index) {
                      final item = controller.historyList[index];
                      final progress = (double.tryParse(item.currentHour) ?? 0) /
                          (double.tryParse(item.targetHour) ?? 1);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            Icons.check_circle,
                                            color: const Color.fromARGB(255, 48, 183, 250),
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.subject,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                "Selesai: ${_formatDate(item.completedAt)}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => controller.deleteHistoryItem(
                                        item.id, item.subject),
                                    tooltip: "Hapus",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.flag_outlined,
                                              size: 16,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "Target: ${item.targetHour} jam",
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer_outlined,
                                              size: 16,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "Tercapai: ${item.currentHour} jam",
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        FractionallySizedBox(
                                          widthFactor: progress.clamp(0.0, 1.0),
                                          child: Container(
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(255, 72, 184, 253),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${(progress * 100).toStringAsFixed(0)}% Completed",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 24, 200, 248),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}