import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TotalPointAndOrdersAndVisetsCard extends StatelessWidget {
  final String title;
  final String? value;
  final String? subValue;
  final String? subValuetwo;
  final String? subTitle;
  final int? numberOfProductsInStore;
  final IconData? icon;
  final Color? color;
  void Function()? onTap;

  TotalPointAndOrdersAndVisetsCard({
    super.key,
    required this.title,
    this.value,
    this.subValue = '',
    this.subValuetwo = '',
    this.subTitle = '',
    this.numberOfProductsInStore,
    this.icon,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffe3ebee), width: 1),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 30),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$numberOfProductsInStore',
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF2CC56F)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
