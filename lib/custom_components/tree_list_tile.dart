import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_plantation_frontend/controllers/image_details_controller.dart';
import 'package:tree_plantation_frontend/controllers/image_reply_controller.dart';
import 'package:tree_plantation_frontend/login.dart';

class TreeListCard extends StatefulWidget {
  final String imgId;
  final String treeImg;
  final String treeDesc;
  final String treeLikes;
  final List replies;
  const TreeListCard({
    Key? key,
    required this.imgId,
    required this.treeImg,
    required this.treeDesc,
    required this.treeLikes,
    required this.replies,
  }) : super(key: key);

  @override
  State<TreeListCard> createState() => _TreeListCardState();
}

class _TreeListCardState extends State<TreeListCard> {
  final ImageDetailsController controller = Get.put(ImageDetailsController());
  final ImageReplyController replyController = Get.put(ImageReplyController());
  final TextEditingController replyText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    print(widget.treeLikes);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: h * 0.6, // Limit the height of each card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h * 0.3,
              width: w,
              child: widget.treeImg != ""
                  ? Image.network(
                      widget.treeImg,
                      fit: BoxFit.fill,
                    )
                  : const Icon(Icons.image),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    controller.likeImg(
                      userName,
                      widget.imgId,
                    );
                  },
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 35,
                  ),
                ),
                Text(
                  widget.treeLikes,
                ),
                IconButton(
                  onPressed: () {
                    replyController.toggleReply();
                  },
                  icon: const Icon(Icons.reply),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: AutoSizeText(
                  widget.treeDesc,
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() {
                    return replyController.isReplying.value
                        ? Column(
                            children: [
                              TextField(
                                controller: replyText,
                                decoration: const InputDecoration(
                                  hintText: "Reply",
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (replyText.text != "") {
                                    replyController.addNewReply(
                                      userName,
                                      widget.imgId,
                                      replyText.text,
                                    );
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "Reply cannot be empty",
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
                                    );
                                  }
                                },
                                child: const Text("Reply"),
                              ),
                            ],
                          )
                        : Container();
                  }),
                  for (var i in widget.replies) Text(i),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
