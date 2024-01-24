import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_plantation_frontend/controllers/profile_screen_controller.dart';
import 'package:tree_plantation_frontend/custom_components/custom_components.dart';
import 'package:tree_plantation_frontend/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    profileController.getImages(userName);
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
          const TreePlatInfo()
        ],
      ),
    );
  }
}
