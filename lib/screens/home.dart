import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iqra/controllers/mark_controller.dart';
import 'package:iqra/screens/read.dart';
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
      appBar: AppBar(title: const Text('ٱقۡرَأۡ')),
      body: Column(
        children: [
          ListTile(
            title: Text('اكمل القراءة'),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Get.to(() => ReadScreen(startPage: markController.mark.value));
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: quran.totalSurahCount,
              itemBuilder: (context, index) {
                int surahNumber = index + 1;
                return ListTile(
                  leading: Text(formatter.format(surahNumber)),
                  title: Text(quran.getSurahNameArabic(surahNumber)),
                  subtitle: Text(
                    quran.getPlaceOfRevelation(surahNumber) == 'Makkah'
                        ? 'مَكِّيَّة'
                        : 'مَدَنِيَّة',
                  ),
                  trailing: Text(
                    formatter.format(quran.getVerseCount(surahNumber)),
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
