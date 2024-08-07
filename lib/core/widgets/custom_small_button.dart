import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';

class CustomSmallButton extends StatelessWidget {
  const CustomSmallButton({
    super.key,
    this.text,
    this.icon,
    this.onTap,
    this.width,
    this.height,
  });
  final String? text;
  final double? height;
  final double? width;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsManager.kPrimaryColor,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
