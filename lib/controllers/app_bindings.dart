import 'package:get/get.dart';
import 'package:iqra/controllers/mark_controller.dart';
import 'package:iqra/controllers/nav_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavController());
    Get.lazyPut(() => MarkController(), fenix: true);
  }
}
