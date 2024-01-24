import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class RewardCard extends StatelessWidget {
  const RewardCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Card(
      color: Color.fromARGB(255, 174, 187, 193),
      elevation: 5,
      child: Column(
        children: [
          SizedBox(
            height: h * 0.1,
            width: w,
            child: Image.asset(
              'assets/images/reward-gold.jpg',
              fit: BoxFit.fill,
            ),
          ),
          AutoSizeText(
            'Zeptop 200 cashback',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextButton(onPressed: () {}, child: Text('Get Reward'))
        ],
      ),
    );
  }
}
