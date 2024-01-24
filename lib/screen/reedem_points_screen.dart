import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_plantation_frontend/controllers/profile_screen_controller.dart';
import 'package:tree_plantation_frontend/custom_components/reward_card.dart';

class ReedemPoints extends StatefulWidget {
  const ReedemPoints({super.key});

  @override
  _ReedemPointsState createState() => _ReedemPointsState();
}

class _ReedemPointsState extends State<ReedemPoints> {
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points and Rewards'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Color.fromARGB(255, 174, 187, 193),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          AutoSizeText(
                            'Points: ${controller.userInfo.value[0]["points"]} ',
                            maxFontSize: 25,
                            minFontSize: 15,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: h * 0.03),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Redeem Points'),
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        thickness: 5,
                        color: Colors.black,
                      ),
                      const Column(
                        children: [
                          AutoSizeText(
                            'Total Winnings\n 100',
                            maxFontSize: 25,
                            minFontSize: 15,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Available Rewards:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Display a list of available rewards or any other relevant information
              Container(
                height: h * 0.6,
                width: w,
                child: GridView.count(
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: h * 0.05,
                    children: [
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                      RewardCard(),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
