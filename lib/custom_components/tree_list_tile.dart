import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_plantation_frontend/controllers/image_details_controller.dart';
import 'package:tree_plantation_frontend/login.dart';
import 'package:tree_plantation_frontend/services/image_services.dart';

class TreeListCard extends StatefulWidget {
  final String imgId;

  const TreeListCard({
    Key? key,
    required this.imgId,
  }) : super(key: key);

  @override
  State<TreeListCard> createState() => _TreeListCardState();
}

class _TreeListCardState extends State<TreeListCard> {
  final ImageDetailsController controller = Get.put(ImageDetailsController());
  var imageData = [];

  @override
  void initState() {
    setImageDetails();
    super.initState();
  }

  Future setImageDetails() async {
    var data = await ImageServices.getImgById(widget.imgId);
    setState(() {
      imageData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    print(widget.imgId);
    print(imageData);
    return SizedBox(
      height: h * 0.12,
      width: w,
      child: Row(
        children: [
          // Leading (image or default icon)
          Container(
            width: w * 0.3,
            child: imageData.isNotEmpty
                ? Image.network(
                    imageData[0]["image"],
                    fit: BoxFit.contain,
                  )
                : const Icon(Icons.image),
          ),
          // Title and Trailing (description, like button, and like count)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Tree Description: ${imageData.isNotEmpty ? imageData[0]["desc"] : ""}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                          size: 25,
                        ),
                      ),
                      AutoSizeText(
                        imageData.isNotEmpty
                            ? imageData[0]["likeCount"].toString()
                            : "",
                        minFontSize: 8,
                        maxFontSize: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
