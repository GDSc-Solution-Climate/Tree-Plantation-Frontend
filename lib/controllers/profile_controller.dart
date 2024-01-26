import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tree_plantation_frontend/services/user_services.dart';

class UploadProfilePic extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  TextEditingController bioController = TextEditingController();
  Future<void> getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> uploadImage() async {
    if (image.value != null) {
      try {
        Uint8List imageBytes = await image.value!.readAsBytes();
        String description =
            'your_image_description'; // Replace with the actual description
        String fileName =
            image.value!.path.split('/').last; // Use the actual file name

        var response = await UserServices.addProfileImage(
          imageBytes: imageBytes,
          description: description,
          filePath: fileName,
        );

        // Handle the response as needed
        if (response.statusCode == 200) {
          image.value = null;
        } else {
          print('Image upload failed with status code: ${response.statusCode}');
          image.value = null;
        }
      } catch (e) {
        print('Error uploading image: $e');
        image.value = null;
      }
    }
  }

  void uploadBio(String userName) async {
    var res = await UserServices.putBioDetails(userName, bioController.text);
    if (res != Error()) {
      Get.snackbar(
        "Success",
        "Bio Updated",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      bioController.clear();
    } else {
      Get.snackbar(
        "Error",
        "Bio Update Failed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      bioController.clear();
    }
  }
}
