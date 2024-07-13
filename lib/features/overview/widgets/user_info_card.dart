import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/label_info_card.dart';

// ignore: camel_case_types
class user_info_card extends StatelessWidget {
  const user_info_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffe3ebee), width: 1),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/user.png'),
            ),
            SizedBox(height: 8),
            Text('Andreas Iniesta',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('+8801774286074', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            LabelInfoCard(
              colorValue: 0xffdcedff,
              contentoflabel: "Aug 20, 1997",
              image: ImagesManger.birthdaycake,
              typeofLabel: 'Birthday',
            ),
            SizedBox(height: 10),
            LabelInfoCard(
              colorValue: 0xffd4f8fc,
              contentoflabel: "Male",
              image: ImagesManger.sex,
              typeofLabel: 'Gender',
            ),
          ],
        ),
      ),
    );
  }
}
