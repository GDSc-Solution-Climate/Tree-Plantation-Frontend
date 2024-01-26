import 'package:get/get.dart';
import 'package:tree_plantation_frontend/services/image_services.dart';

class ImageDetailsController extends GetxController {
  RxList imgDetails = [].obs;
  RxInt imgLikes = 0.obs;
  Future<void> getImgDetail(String imgId) async {
    imgDetails.clear();
    var res = await ImageServices.getImgById(imgId);
    imgDetails.assignAll(res);
  }

  void likeImg(String user,String imageId) async {
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
}
