import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iqra/controllers/mark_controller.dart';
import 'package:iqra/screens/read.dart';

class MarksScreen extends StatefulWidget {
  const MarksScreen({super.key});

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  final MarkController markController = Get.find();
  var formatter = NumberFormat.decimalPattern('ar_EG');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('العلامات')),
      body: Obx(
        () => markController.mark.isEmpty
            ? const Center(child: Text('لا يوجد علامات'))
            : ListView.builder(
                itemCount: markController.mark.length,
                itemBuilder: (context, index) {
                  int pageNumber = markController.mark[index];
                  return ListTile(
                    title: Text(
                      'الصفحة ${formatter.format(pageNumber)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        markController.removeMark(pageNumber);
                      },
                    ),
                    onTap: () {
                      // Navigate to the ReadScreen with the selected page
                      Get.to(() => ReadScreen(startPage: pageNumber));
                    },
                  );
                },
              ),
      ),
    );
  }
}
