import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MarkController extends GetxController {
  final box = GetStorage();
  final mark = 1.obs;

  static const _key = 'mark';

  @override
  void onInit() {
    super.onInit();
    mark.value = box.read(_key) ?? 1;
  }

  void setMark(int value) {
    mark.value = value;
    box.write(_key, value);
  }
}
