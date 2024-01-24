import 'package:get/get.dart';
import 'package:tree_plantation_frontend/services/user_services.dart';

class ProfileController extends GetxController {
  RxList userInfo = [].obs; // Assuming userInfo is a Map<String, dynamic>
  RxList images = [].obs;
  void getUserData(String userName) async {
    var res = await UserServices.getUserByName(userName);
    if (res != Error()) {
      print(res);

      // Convert the regular list to RxList
      RxList<dynamic> rxList = RxList.from(res);

      // Assign the RxList to userInfo
      userInfo.assignAll(rxList);

      print(userInfo);
    } else {
      Get.snackbar(
        "Error",
        "Error Getting your details",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void getImages(String userId) async{
    var res = await UserServices.getImagesById(userId);
    if (res != Error()) {
      print(res);

      // Convert the regular list to RxList
      RxList<dynamic> rxList = RxList.from(res);

      // Assign the RxList to userInfo
      images.assignAll(rxList);

      print(images);
    } else {
      Get.snackbar(
        "Error",
        "Error Getting your details",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
