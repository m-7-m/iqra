import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MarkController extends GetxController {
  final box = GetStorage();
  final mark = [].obs;

  static const _key = 'mark';

  @override
  void onInit() {
    super.onInit();
    mark.value = List<int>.from(box.read<List>(_key) ?? []);
  }

  void setMark(int value) {
    mark.add(value);
    box.write(_key, mark.toList());
  }

  void removeMark(int value) {
    mark.remove(value);
    box.write(_key, mark.toList());
  }
}
