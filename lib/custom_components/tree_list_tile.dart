import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_plantation_frontend/controllers/image_details_controller.dart';
import 'package:tree_plantation_frontend/controllers/image_reply_controller.dart';
import 'package:tree_plantation_frontend/custom_components/child_tree_list_card.dart';
import 'package:tree_plantation_frontend/login.dart';
import 'package:tree_plantation_frontend/screen/add_child_images.dart';
import 'package:tree_plantation_frontend/services/image_services.dart';
import 'package:tree_plantation_frontend/services/user_services.dart';

class TreeListCard extends StatefulWidget {
  final String imgId;
  final String treeImg;
  final String treeDesc;
  final String treeLikes;
  final List replies;
  final String owner;
  const TreeListCard({
    Key? key,
    required this.imgId,
    required this.treeImg,
    required this.treeDesc,
    required this.treeLikes,
    required this.replies,
    required this.owner,
  }) : super(key: key);

  @override
  State<TreeListCard> createState() => _TreeListCardState();
}

class _TreeListCardState extends State<TreeListCard> {
  final ImageDetailsController controller = Get.put(ImageDetailsController());
  final ImageReplyController replyController = Get.put(ImageReplyController());
  final TextEditingController replyText = TextEditingController();
  bool _isReplying = false;
  bool isChildImgSearched = false;
  List userDetail = [];
  List childImageList = [];
  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future getUser() async {
    var res = await UserServices.getUserByUserId(widget.owner);
    print(res);
    if (res != Error()) {
      setState(() {
        userDetail = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: isChildImgSearched
            ? h * 0.9
            : h * 0.7, // Limit the height of each card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage:
                        userDetail.isNotEmpty && userDetail.contains("avatar")
                            ? NetworkImage('${userDetail[0]["avatar"]}')
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AutoSizeText(
                    userDetail.isNotEmpty
                        ? userDetail[0]["username"]
                        : "Loading...",
                    minFontSize: 20,
                    maxFontSize: 30,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
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
                    if (userName == userDetail[0]['username']) {
                      Get.to(() => AddChildImage(imgId: widget.imgId));
                    } else {
                      print(_isReplying);
                      setState(() {
                        _isReplying = !_isReplying;
                      });
                    }
                  },
                  icon: const Icon(Icons.reply),
                ),
                SizedBox(
                  width: w * 0.45,
                ),
                IconButton(
                  onPressed: () async {
                    var newIsChildImgSearched = !isChildImgSearched;
                    if (newIsChildImgSearched) {
                      var res = await ImageServices.getChildImage(
                          widget.owner, widget.imgId);
                      if (res != Error()) {
                        setState(() {
                          print("response: ${res[0][0]['image']}");
                          isChildImgSearched = newIsChildImgSearched;
                          childImageList = res[0];
                        });
                      } else {
                        Get.snackbar(
                          "Error",
                          "Error getting child images",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                        );
                      }
                    } else {
                      setState(() {
                        isChildImgSearched = newIsChildImgSearched;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 40,
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: h * 0.05,
                child: AutoSizeText(
                  widget.treeDesc,
                  maxLines: 5,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              height: 0.1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _isReplying
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: w * 0.6,
                                child: TextField(
                                  controller: replyText,
                                  decoration: const InputDecoration(
                                    hintText: "Reply",
                                  ),
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
                                child: const Icon(Icons.send),
                              ),
                            ],
                          )
                        : Container(),
                    for (var i in widget.replies) Text(i),
                  ],
                ),
              ),
            ),
            isChildImgSearched && childImageList.isNotEmpty
                ? SizedBox(
                    height: h * 0.3,
                    child: ListView.builder(
                      itemCount: childImageList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ChildTreeImageCard(
                              treeImg: childImageList[index]["image"],
                              treeDesc: childImageList[index]["desc"],
                              treeLikes: childImageList[index]["likeCount"]
                                  .toString(),
                              imgId: childImageList[index]["_id"],
                              replies: childImageList[index]["reply"],
                              owner: childImageList[index]["owner"],
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    ));
  }
}
