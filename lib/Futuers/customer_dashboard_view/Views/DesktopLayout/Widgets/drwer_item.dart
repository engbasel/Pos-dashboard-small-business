import 'package:flutter/material.dart';

Widget DrawerItem({
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
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green, Colors.yellow], // Gradient colors
              ),
              borderRadius: BorderRadius.circular(
                  30), // Adjust the border radius as needed
            ),
          ),
          const SizedBox(width: 35),
          Icon(
            icon,
            color: isSelected ? const Color(0xff2cc56f) : null,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xff2cc56f)
                    : const Color(0xff828282),
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
