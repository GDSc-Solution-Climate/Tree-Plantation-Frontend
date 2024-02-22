import 'dart:ffi';

import 'package:get/get.dart';
import 'package:tree_plantation_frontend/services/image_services.dart';

class ImageDetailsController extends GetxController {
  RxList imgDetails = [].obs;
  RxInt imgLikes = 0.obs;
  RxBool imgLoading = true.obs;
  RxList childImgList = [].obs;
  RxBool isChildImgSearched = false.obs;

  void getImgDetail() async {
    var res = await ImageServices.getAllImages();
    print(res);
    imgDetails.assignAll(res);
    print(imgDetails);
    imgLoading.value = false;
  }

  void likeImg(String user, String imageId) async {
    var res = await ImageServices.likeImage(user, imageId);
    if (res != Error()) {
      imgLikes.value = res[0]["user"]["likeCount"];
    } else {
      Get.snackbar(
        "Error",
        "Error liking the image",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void getImgChild(String userId, String imgId) async {
    var res = await ImageServices.getChildImage(userId, imgId);
    if (res != Error()) {
      childImgList.assignAll(res);
    } else {
      Get.snackbar(
        "Error",
        "Error getting child images",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void seeChildImage(String userId, String imgId) {
    getImgChild(userId, imgId);
    isChildImgSearched.value = !isChildImgSearched.value;
    if (isChildImgSearched.value == false){
      childImgList.clear();
    }
  }
}
