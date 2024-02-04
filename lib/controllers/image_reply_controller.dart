import 'package:get/get.dart';
import 'package:tree_plantation_frontend/services/image_services.dart';

class ImageReplyController extends GetxController {
  RxBool isReplying = false.obs;

  Future<void> addNewReply(
      String userName, String imgId, String replyText) async {
    var res = await ImageServices.replyToPost(userName, imgId, replyText);
    if (res != Error()) {
      Get.snackbar(
        "Success",
        "Reply added successfully",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        "Error",
        "Error adding reply",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
    isReplying.value = !isReplying.value;
  }

  void toggleReply() {
    isReplying.value = !isReplying.value;
  }
}
