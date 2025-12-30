import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iqra/screens/read.dart';
import 'package:quran/quran.dart' as quran;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  var formatter = NumberFormat.decimalPattern('ar_EG');
  List result = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('البحث')),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'البحث...',
                prefixIcon: Icon(Icons.search),
                border: UnderlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isEmpty) return;
                String normalize(String text) {
                  return text
                      .replaceAll(
                        RegExp(
                          r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E8\u06EA-\u06ED]',
                        ),
                        '',
                      )
                      .replaceAll(RegExp(r'[أإآٱ]'), 'ا')
                      .replaceAll('ة', 'ه')
                      .replaceAll('ى', 'ي');
                }

                String query = normalize(value);
                List tempResult = [];

                for (int s = 1; s <= 114; s++) {
                  int count = quran.getVerseCount(s);
                  for (int v = 1; v <= count; v++) {
                    if (normalize(quran.getVerse(s, v)).contains(query)) {
                      tempResult.add({
                        'surah': s,
                        'verse': v,
                        'text': quran.getVerse(s, v),
                      });
                    }
                  }
                }

                setState(() {
                  result = tempResult;
                });
              },
            ),
            Expanded(
              child: result.isEmpty
                  ? const Center(child: Text('لا يوجد نتائج'))
                  : ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        int surahNumber = result[index]['surah'];
                        int ayahNumber = result[index]['verse'];
                        int pageNumber = quran.getPageNumber(
                          surahNumber,
                          ayahNumber,
                        );
                        return ListTile(
                          title: Text(
                            '${quran.getSurahNameArabic(surahNumber)} ${formatter.format(ayahNumber)}',
                          ),
                          subtitle: Text(
                            quran.getVerse(surahNumber, ayahNumber),
                          ),
                          trailing: Text(
                            'الصفحة ${formatter.format(pageNumber)}',
                          ),
                          onTap: () =>
                              Get.to(() => ReadScreen(startPage: pageNumber)),
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
