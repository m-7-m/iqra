import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iqra/controllers/app_bindings.dart';
import 'package:iqra/controllers/nav_controller.dart';
import 'package:iqra/screens/home.dart';
import 'package:iqra/screens/settings.dart';
import 'package:iqra/widgets/navbar.dart';

void main() async {
  Intl.defaultLocale = 'ar_EG';
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.amiriTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlueAccent,
          brightness: Brightness.light,
        ),
      ),
      themeMode: ThemeMode.light,
      initialBinding: AppBindings(),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NavController navController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: navController.index.value,
          children: [HomeScreen(), SettingsScreen()],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
