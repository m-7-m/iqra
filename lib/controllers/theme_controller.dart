import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final box = GetStorage();
  var currentTheme = 0xFFD4AF37.obs;

  @override
  void onInit() {
    super.onInit();
    currentTheme.value = box.read('theme') ?? 0xFFD4AF37;
  }

  void setTheme(int color) {
    currentTheme.value = color;
    box.write('theme', color);
    update();
  }
}
