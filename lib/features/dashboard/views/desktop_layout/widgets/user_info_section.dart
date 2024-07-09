import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/custom_label.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15,
          ),
          color: Colors.white,
        ),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomLabel(
                  color: Color(0xfffff2cc),
                  labelValue: 'Email',
                  content: 'abcd123@gmail.com',
                  imagename: ImagesManger.mail,
                ),
                CustomLabel(
                  color: Color(0xfff3e5f5),
                  labelValue: 'Register Since',
                  content: 'Aug 22, 2022',
                  imagename: ImagesManger.edit,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLabel(
                  color: Color(0xffe0f7fa),
                  labelValue: 'Favourite Branch',
                  content: 'Branch A',
                  imagename: ImagesManger.agency,
                ),
                CustomLabel(
                  color: Color(0xffffebee),
                  labelValue: 'Favourite Item',
                  content: 'Pizza',
                  imagename: ImagesManger.shoppingbag,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
