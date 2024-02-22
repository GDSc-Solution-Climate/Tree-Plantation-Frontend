// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tree_plantation_frontend/services/image_upload_service.dart';

// class ImageController extends GetxController {
//   Rx<File?> image = Rx<File?>(null);
//   final TextEditingController description = TextEditingController();
//   Rx<File?> childImage = Rx<File?>(null);
//   final TextEditingController childImageDesc = TextEditingController();

//   Future<void> getImage(ImageSource source) async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: source);

//     if (pickedFile != null) {
//       image.value = File(pickedFile.path);
//       print(image.value!.path.split('.').last);
//     }
//   }

//   Future<void> getChildImage(ImageSource source) async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: source);

//     if (pickedFile != null) {
//       childImage.value = File(pickedFile.path);
//       print(childImage.value!.path.split('.').last);
//     }
//   }

//   Future<void> uploadImage() async {
//     if (image.value != null) {
//       try {
//         Uint8List imageBytes = await image.value!.readAsBytes();
//         String descriptionText = description.text;
//         String fileName = image.value!.path.split('/').last;

//         var response = await ImageUploadService.uploadImage(
//           imageBytes: imageBytes,
//           description: descriptionText,
//           filePath: fileName,
//         );

//         if (response.statusCode == 200) {
//           image.value = null;
//         } else {
//           print('Image upload failed with status code: ${response.statusCode}');
//           // Handle the error, e.g., notify the user or log the error details
//         }
//       } catch (e) {
//         print('Error uploading image: $e');
//         // Handle the error, e.g., notify the user or log the error details
//       }
//     }
//   }

//   Future<void> uploadChildImage(String imgId) async {
//     try {
//       Uint8List imageBytes = await childImage.value!.readAsBytes();
//       String descriptionText = description.text;
//       String fileName = image.value!.path.split('/').last;
//       print(childImage.value);
//       var response = await ImageUploadService.uploadChildImage(
//         imageBytes: imageBytes,
//         description: descriptionText,
//         filePath: fileName,
//         imgId: imgId,
//       );

//       if (response.statusCode == 200) {
//         childImage.value = null;
//       } else {
//         print('Image upload failed with status code: ${response.statusCode}');
//         // Handle the error, e.g., notify the user or log the error details
//       }
//     } catch (e) {
//       print('Error uploading image: $e');
//       // Handle the error, e.g., notify the user or log the error details
//     }
//   }
// }

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tree_plantation_frontend/services/image_upload_service.dart';

class ImageController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  final TextEditingController description = TextEditingController();
  Rx<File?> childImage = Rx<File?>(null);
  final TextEditingController childImageDesc = TextEditingController();

  @override
  void dispose() {
    description.dispose();
    childImageDesc.dispose();
    super.dispose();
  }

  Future<void> getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      print(image.value!.path.split('.').last);
    }
  }

  Future<void> getChildImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      childImage.value = File(pickedFile.path);
      print(childImage.value!.path.split('.').last);
    }
  }

  Future<void> uploadImage() async {
    if (image.value != null) {
      try {
        Uint8List imageBytes = await image.value!.readAsBytes();
        String descriptionText = description.text;
        String fileName = image.value!.path.split('/').last;

        var response = await ImageUploadService.uploadImage(
          imageBytes: imageBytes,
          description: descriptionText,
          filePath: fileName,
        );

        if (response.statusCode == 200) {
          image.value = null;
        } else {
          print('Image upload failed with status code: ${response.statusCode}');
          // Handle the error, e.g., notify the user or log the error details
        }
      } catch (e) {
        print('Error uploading image: $e');
        // Handle the error, e.g., notify the user or log the error details
      }
    }
  }

  Future<void> uploadChildImage(String imgId) async {
    try {
      Uint8List imageBytes = await childImage.value!.readAsBytes();
      String descriptionText = childImageDesc.text;
      String fileName = childImage.value!.path.split('/').last;

      var response = await ImageUploadService.uploadChildImage(
        imageBytes: imageBytes,
        description: descriptionText,
        filePath: fileName,
        imgId: imgId,
      );

      if (response.statusCode == 200) {
        childImage.value = null;
      } else {
        print('Image upload failed with status code: ${response.statusCode}');
        // Handle the error, e.g., notify the user or log the error details
      }
    } catch (e) {
      print('Error uploading child image: $e');
      // Handle the error, e.g., notify the user or log the error details
    }
  }
}
