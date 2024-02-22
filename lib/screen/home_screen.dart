import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tree_plantation_frontend/controllers/image_details_controller.dart';
import 'package:tree_plantation_frontend/login.dart';
import 'package:tree_plantation_frontend/custom_components/tree_list_tile.dart';
import 'package:tree_plantation_frontend/controllers/profile_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final ImageDetailsController imgController =
      Get.put(ImageDetailsController());

  @override
  void initState() {
    imgController.getImgDetail();
    profileController.getUserData(userName);
    super.initState();
  }

  @override
  void dispose() {
    imgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Column(
        children: [
          Container(
            height: h * 0.1,
            width: w,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                blurStyle: BlurStyle.outer,
              )
            ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: AutoSizeText(
                    'Welcome',
                    minFontSize: 20,
                    maxFontSize: 30,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: AutoSizeText(
                    '${userName.capitalize}👋',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => imgController.imgLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: h * 0.9,
                      width: w,
                      child: ListView.builder(
                        itemCount: imgController.imgDetails.isNotEmpty
                            ? imgController.imgDetails.length
                            : 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              TreeListCard(
                                treeImg: imgController.imgDetails[index]
                                    ["image"],
                                treeDesc: imgController.imgDetails[index]
                                    ["desc"],
                                treeLikes: imgController.imgDetails[index]
                                        ["likeCount"]
                                    .toString(),
                                imgId: imgController.imgDetails[index]
                                    ["_id"],
                                replies: imgController.imgDetails[index]
                                    ["reply"],
                                owner: imgController.imgDetails[index]
                                    ["owner"],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
