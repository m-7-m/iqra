import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iqra/constants/hezb_name.dart';
import 'package:iqra/constants/juz_name.dart';
import 'package:iqra/controllers/mark_controller.dart';
import 'package:quran/quran.dart' as quran;

class ReadScreen extends StatefulWidget {
  final int? startPage;
  const ReadScreen({super.key, this.startPage});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  var formatter = NumberFormat.decimalPattern('ar_EG');
  late PageController _controller;
  final MarkController markController = Get.find();

  @override
  void initState() {
    super.initState();
    if (widget.startPage != null) {
      _controller = PageController(initialPage: widget.startPage! - 1);
    } else {
      _controller = PageController(initialPage: markController.mark.value - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: 604,
          itemBuilder: (context, index) {
            int pageNumber = index + 1;
            int surahNumber = quran.getPageData(pageNumber)[0]['surah'];
            int verseNumber = quran.getPageData(pageNumber)[0]['end'];
            int juzNumber = quran.getJuzNumber(surahNumber, verseNumber);
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: Colors.lightBlueAccent[50]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(juzName[juzNumber]!),
                      Text(
                        hezbName[pageNumber] ??
                            quran.getSurahNameArabic(surahNumber),
                      ),
                      Obx(
                        () => IconButton(
                          onPressed: () {
                            markController.setMark(pageNumber);
                          },
                          icon: markController.mark.value == pageNumber
                              ? Icon(Icons.bookmark)
                              : Icon(Icons.bookmark_outline),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/quran-images/${index + 1}.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    formatter.format(pageNumber),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
