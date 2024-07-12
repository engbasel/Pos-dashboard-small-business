import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/labelInfoCard.dart';

// ignore: camel_case_types
class user_info_card extends StatelessWidget {
  const user_info_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
        left: 8,
        right: 8,
        top: 17,
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffe3ebee), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/user.png'),
            ),
            const SizedBox(height: 8),
            const Text('Andreas Iniesta',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('+8801774286074', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            labelInfoCard(
              ColorValue: 0xffdcedff,
              contentoflabel: "Aug 20, 1997",
              image: ImagesManger.birthdaycake,
              typeofLabel: 'Birthday',
            ),
            const SizedBox(height: 10),
            labelInfoCard(
              ColorValue: 0xffd4f8fc,
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
