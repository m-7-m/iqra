import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iqra/constants/theme.dart';
import 'package:iqra/controllers/theme_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeController themeController = Get.put(ThemeController());
  var formatter = NumberFormat.decimalPattern('ar_EG');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الاعدادات')),
      body: ListView.builder(
        itemCount: theme.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              formatter.format(index + 1),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            title: Text(
              '${theme.keys.toList()[index]}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: Icon(
              Icons.circle,
              color: Color(theme.values.toList()[index]),
            ),
            onTap: () => themeController.setTheme(theme.values.toList()[index]),
          );
        },
      ),
    );
  }
}
