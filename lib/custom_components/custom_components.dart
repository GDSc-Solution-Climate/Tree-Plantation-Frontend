import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TreePlatInfo extends StatelessWidget {
  const TreePlatInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                height: h * 0.1,
                width: w * 0.3,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              title: AutoSizeText('Tree Name'),
              subtitle: Text('Tree Planting Location'),
            ),
            Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                // children: [
                //   TextButton(
                //     child: const Text('BUY TICKETS'),
                //     onPressed: () {},
                //   ),
                //   const SizedBox(width: 8),
                //   TextButton(
                //     child: const Text('LISTEN'),
                //     onPressed: () {/* ... */},
                //   ),
                //   const SizedBox(width: 8),
                // ],
                ),
          ],
        ),
      ),
    );
  }
}
