import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iqra/controllers/mark_controller.dart';
import 'package:iqra/screens/read.dart';
import 'package:iqra/screens/search.dart';
import 'package:quran/quran.dart' as quran;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var formatter = NumberFormat.decimalPattern('ar_EG');
  final MarkController markController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/iqra.png', height: 40),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => ReadScreen(
                  startPage: markController.mark.isEmpty
                      ? 1
                      : markController.mark.last,
                ),
              );
            },
            icon: Icon(Icons.bookmark),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Get.to(() => SearchScreen());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: quran.totalSurahCount,
              itemBuilder: (context, index) {
                int surahNumber = index + 1;
                return ListTile(
                  tileColor: index.isEven
                      ? Theme.of(context).colorScheme.surfaceContainer
                      : null,
                  leading: Text(
                    formatter.format(surahNumber),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  title: Text(
                    quran.getSurahNameArabic(surahNumber),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    quran.getPlaceOfRevelation(surahNumber) == 'Makkah'
                        ? 'مَكِّيَّة'
                        : 'مَدَنِيَّة',
                  ),
                  trailing: Text(
                    formatter.format(quran.getVerseCount(surahNumber)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      () => ReadScreen(
                        startPage: quran.getSurahPages(surahNumber)[0],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
