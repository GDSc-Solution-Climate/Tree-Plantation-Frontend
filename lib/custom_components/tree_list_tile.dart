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
      height: h * 0.8,
      width: w,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: w,
          height: h * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.3,
                width: w,
                child: imageData.isNotEmpty
                    ? Image.network(
                        imageData[0]["image"],
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
                      setImageDetails();
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      size: 35,
                    ),
                  ),
                  AutoSizeText(
                    imageData.isNotEmpty
                        ? imageData[0]["likeCount"].toString()
                        : "",
                    minFontSize: 10,
                    maxFontSize: 18,
                  ),
                ],
              ),
              AutoSizeText(
                '${imageData.isNotEmpty ? imageData[0]["desc"] : ""}',
                maxLines: 5,
                minFontSize: 15,
                maxFontSize: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
