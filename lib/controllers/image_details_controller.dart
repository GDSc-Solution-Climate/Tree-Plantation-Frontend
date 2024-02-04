import 'package:get/get.dart';
import 'package:tree_plantation_frontend/services/image_services.dart';

class ImageDetailsController extends GetxController {
  RxList imgDetails = [].obs;
  RxInt imgLikes = 0.obs;
  RxBool imgLoading = true.obs;

  // @override
  // void onInit() {
  //   getImgDetail();
  //   super.onInit();
  // }

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
}
