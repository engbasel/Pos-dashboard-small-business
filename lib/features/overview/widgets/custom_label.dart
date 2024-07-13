import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String labelValue, content, imagename;
  final Color color;

  const CustomLabel({
    super.key,
    required this.labelValue,
    required this.color,
    required this.imagename,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              imagename,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labelValue,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(content),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
