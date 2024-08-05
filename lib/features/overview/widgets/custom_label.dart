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
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    );
  }
}
