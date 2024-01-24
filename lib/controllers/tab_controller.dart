import 'package:get/get.dart';

class TabControler extends GetxController {
  var selectedIndex = 0.obs;
  @override
  onInit() {
    super.onInit();
    // this._selectedIndex = 0.obs;
  }

  changeIndex(int index) {
    selectedIndex.value = index;
  }
}