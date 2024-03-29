import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tree_plantation_frontend/controllers/ai_image_controller.dart';
import 'package:tree_plantation_frontend/services/ai_services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final RxList<dynamic> messages =
      [].obs; // Changed to dynamic to handle both String and File
  final RxBool isLoading = false.obs;
  final AiImageController controller = Get.put(AiImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask AI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  return ListTile(
                    title: Text(
                      message,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                Obx(() {
                  return IconButton(
                    onPressed: controller.image.value != null
                        ? () async {
                            String message = messageController.text;
                            if (message.isNotEmpty) {
                              isLoading.value = true;
                              messages.add(message);
                              messageController.clear();
                              await controller.uploadImage(message);
                              if (controller.res.value != '') {
                                messages.add(controller.res.value);
                              }
                              isLoading.value = false;
                            }
                          }
                        : isLoading.value
                            ? null
                            : () async {
                                String message = messageController.text;
                                if (message.isNotEmpty) {
                                  isLoading.value = true;
                                  messages.add(message);
                                  messageController.clear();
                                  var res =
                                      await AIServices.textAiResponse(message);
                                  if (res is List) {
                                    messages.addAll(
                                        res.map((message) => message['name']));
                                  } else if (res is Map) {
                                    messages.add(res[0]['name']);
                                  }
                                  isLoading.value = false;
                                }
                              },
                    icon: const Icon(Icons.send),
                  );
                }),
                IconButton(
                  onPressed: () {
                    Get.bottomSheet(
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
                    );
                  },
                  icon: const Icon(Icons.attach_file_sharp),
                ),
              ],
            ),
          ),
          Obx(() {
            return isLoading.value
                ? const CircularProgressIndicator()
                : Container();
          }),
        ],
      ),
    );
  }
}
