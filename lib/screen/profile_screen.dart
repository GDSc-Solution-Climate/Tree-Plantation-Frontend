import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tree_plantation_frontend/controllers/profile_controller.dart';
import 'package:tree_plantation_frontend/controllers/profile_screen_controller.dart';
import 'package:tree_plantation_frontend/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UploadProfilePic controller = Get.put(UploadProfilePic());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.getUserData(userName);
  }

  @override
  Widget build(BuildContext context) {
    print(profileController.userInfo[0].containsKey('bio'));
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_sharp),
            onPressed: () {
              controller.uploadImage();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Obx(() {
                  return CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        profileController.userInfo[0].containsKey("avatar") &&
                                controller.image.value == null
                            ? NetworkImage(
                                "${profileController.userInfo[0]["avatar"]}")
                            : controller.image.value == null
                                ? const AssetImage('assets/images/profile.png')
                                    as ImageProvider<Object>?
                                : FileImage(controller.image.value!),
                  );
                }),
                Positioned(
                  top: h * 0.13,
                  left: w * 0.3,
                  child: IconButton(
                    onPressed: () {
                      controller.image.value == null
                          ? Get.bottomSheet(
                              elevation: 2,
                              backgroundColor: Colors.white,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    onPressed: () => controller
                                        .getImage(ImageSource.gallery),
                                    icon: const Icon(
                                      Icons.image_sharp,
                                      size: 50,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : controller.uploadImage();
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.grey,
                      size: w * 0.13,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.05),
            Text(
              '${userName.capitalize}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Date Of Joining: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(profileController.userInfo[0]["createdAt"]))}',
                      minFontSize: 20,
                      maxFontSize: 25,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    AutoSizeText(
                      "Email: ${profileController.userInfo[0]["email"]}",
                      minFontSize: 15,
                      maxFontSize: 20,
                      style: const TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: h * 0.02),
                    Row(
                      children: [
                        const AutoSizeText(
                          "Bio",
                          minFontSize: 25,
                          maxFontSize: 30,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: const Text('Add Bio'),
                                  content: TextField(
                                    controller: controller.bioController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Bio',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        controller.bioController.clear();
                                        Get.back();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.uploadBio(userName);
                                        Get.back();
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ],
                                );
                              }),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    profileController.userInfo[0].containsKey('bio')
                        ? AutoSizeText(
                            profileController.userInfo[0]["bio"],
                            minFontSize: 15,
                            maxFontSize: 20,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        : const AutoSizeText(
                            "Add Bio",
                            minFontSize: 15,
                            maxFontSize: 20,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add functionality for another action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'LogOut',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
