import 'package:get/get.dart';

class NavController extends GetxController {
  var index = 0.obs;
  void setIndex(int value) {
    index.value = value;
  }
}
