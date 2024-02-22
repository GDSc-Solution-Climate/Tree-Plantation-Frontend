import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tree_plantation_frontend/services/ai_services.dart';

class AiImageController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  Future<void> getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      print(image.value!.path.split('.').last);
    }
  }

  Future<void> uploadImage(String prompt) async {
    if (image.value != null) {
      try {
        Uint8List imageBytes = await image.value!.readAsBytes();
        String descriptionText = prompt;
        String fileName = image.value!.path.split('/').last;

        var response = await AIServices.uploadImage(
          imageBytes: imageBytes,
          prompt: descriptionText,
          filePath: fileName,
        );

        if (response.statusCode == 200) {
          // ...

          var responseData = jsonDecode(
              await http.ByteStream(response.stream).bytesToString());
          print('Image upload successful. Response: $responseData');
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
}
