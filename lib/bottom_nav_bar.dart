import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tree_plantation_frontend/controllers/tab_controller.dart';
import 'package:tree_plantation_frontend/screen/home_screen.dart';
import 'package:tree_plantation_frontend/screen/image_upload_screen.dart';
import 'package:tree_plantation_frontend/screen/profile_screen.dart';
import 'package:tree_plantation_frontend/screen/reedem_points_screen.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const HomeScreen(),
      const ImageUploadScreen(),
      ReedemPoints(),
      const ProfileScreen()
    ];
    final TabControler tabControler = Get.put(TabControler());
    return Scaffold(
      body: Obx(
        () => Center(
          child: widgetOptions.elementAt(tabControler.selectedIndex.value),
        ),
      ),
      bottomNavigationBar: GNav(
        gap: 10,
        backgroundColor: Colors.white,
        color: Colors.purpleAccent,
        activeColor: Colors.purpleAccent,
        onTabChange: (index) {
          tabControler.selectedIndex.value = index;
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
            textColor: Color.fromARGB(255, 193, 129, 245),
          ),
          GButton(
            icon: Icons.camera_alt_rounded,
            text: 'Image',
            textColor: Color.fromARGB(255, 193, 129, 245),
          ),
          GButton(
            icon: Icons.currency_bitcoin_sharp,
            text: 'Points',
            textColor: Color.fromARGB(255, 193, 129, 245),
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            textColor: Color.fromARGB(255, 193, 129, 245),
          ),
        ],
      ),
    );
  }
}
//design kar du? kr de waise bhi itna kam time diye hai
//ok kal office bhi jaana hai aur parso subha meeting lund hai saale
//kar de raha thax bhai:' ) yaha se le lo access mere pass hi hai ok