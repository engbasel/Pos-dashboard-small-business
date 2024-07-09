import 'package:flutter/material.dart';

import '../Widgets/UserInfoScetion.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                UserInfoSection(),

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
            ),
            Column(
              children: [
                //  card of Proile user
              ],
            )
          ],
        ),
        Row(
          children: [
            // Text('Order List'),
          ],
        ),
      ],
    );
  }
}
