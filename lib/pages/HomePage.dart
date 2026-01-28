// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:simple_learning_tracker/controllers/controller_homepage.dart';


// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.find<HomeController>();

//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: const Text(
//           "Learning Tracker",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: Obx(
//         () => controller.isLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : controller.learningList.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.school_outlined, size: 100, color: Colors.grey[400]),
//                         const SizedBox(height: 16),
//                         Text(
//                           "Belum ada progress belajar",
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : ListView.builder(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: controller.learningList.length,
//                     itemBuilder: (context, index) {
//                       final item = controller.learningList[index];
//                       final progress = (double.tryParse(item.currentHour) ?? 0) /
//                           (double.tryParse(item.targetHour) ?? 1);

//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       item.subject,
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       IconButton(
//                                         icon: const Icon(Icons.edit, color: Colors.blue),
//                                         onPressed: () => controller.editItem(item),
//                                         tooltip: "Update",
//                                       ),
//                                       IconButton(
//                                         icon: const Icon(Icons.delete, color: Colors.red),
//                                         onPressed: () => controller.deleteItem(item.id, item.subject),
//                                         tooltip: "Delete",
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Target: ${item.targetHour} jam",
//                                     style: TextStyle(color: Colors.grey[600]),
//                                   ),
//                                   Text(
//                                     "Progress: ${item.currentHour} jam",
//                                     style: TextStyle(color: Colors.grey[600]),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               LinearProgressIndicator(
//                                 value: progress.clamp(0.0, 1.0),
//                                 backgroundColor: Colors.grey[300],
//                                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
//                                 minHeight: 8,
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 "${(progress * 100).toStringAsFixed(0)}%",
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => Get.find<HomeController>().navigateToCreatePage(),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         icon: const Icon(Icons.add),
//         label: const Text("Tambah"),
//       ),
//     );
//   }
// }