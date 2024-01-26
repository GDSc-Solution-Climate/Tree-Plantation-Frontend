import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tree_plantation_frontend/controllers/image_controller.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);
  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final ImageController controller = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() {
              return controller.image.value == null
                  ? const Text('No image selected.')
                  : Image.file(
                      controller.image.value!,
                      width: w * 0.8,
                      height: h * 0.3,
                    );
            }),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.description,
                decoration: const InputDecoration(
                  labelText: 'Image Description',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              // onPressed: () => controller.uploadImage(),
              onPressed: () {
                controller.image.value == null
                    ? Get.bottomSheet(
                        elevation: 2,
                        backgroundColor: Colors.white,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  controller.getImage(ImageSource.camera),
                              icon: const Icon(
                                Icons.camera_alt_rounded,
                                size: 50,
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  controller.getImage(ImageSource.gallery),
                              icon: const Icon(
                                Icons.image_sharp,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                      )
                    : controller.description == ""
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please Enter the description"),
                            ),
                          )
                        : controller.uploadImage();
              },
              child: Obx(() {
                return controller.image.value == null
                    ? const AutoSizeText("Select Image")
                    : const AutoSizeText("Upload Image");
              }),
            ),
          ],
        ),
      ),
    );
  }
}
