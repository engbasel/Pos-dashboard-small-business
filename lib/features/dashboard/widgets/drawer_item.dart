import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';

Widget drawerItem({
  required int index,
  required IconData icon,
  required String text,
  required bool isSelected,
  GestureTapCallback? onTap,
  int badgeCount = 0,
}) {
  return ListTile(
    contentPadding: const EdgeInsets.all(0),
    title: Container(
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xff505251) : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: isSelected ? 7.5 : 0, // Adjust width as needed
            height: isSelected ? 40 : 0, // Adjust height as needed
            decoration: BoxDecoration(
              color: ColorsManager.kPrimaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(width: 35),
          Icon(
            icon,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
    selected: isSelected,
    onTap: onTap,
  );
}
