import 'package:flutter/material.dart';

class CoustomCatigoryCard extends StatelessWidget {
  final String containerTitle;
  final VoidCallback ontap;
  final Color bacColor;

  const CoustomCatigoryCard({
    super.key,
    required this.containerTitle,
    required this.ontap,
    required this.bacColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 300,
        height: 300,
        color: bacColor,
        child: Center(
          child: Text(containerTitle),
        ),
      ),
    );
  }
}
