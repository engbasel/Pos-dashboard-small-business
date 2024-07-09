import 'package:flutter/material.dart';

import '../Widgets/UserInfoScetion.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Column(
              children: [
//  section 1
// email and
// Favourite Item
// Register Since
//Favourite Branch

//  section 2
// Total Points
// Oders
// Total Visits
              ],
            )
          ],
        ),
        Row(
          children: [
            // Text('Order List'),
            UserInfoScetion(),
          ],
        ),
      ],
    );
  }
}
