import 'package:flutter/material.dart';

class CustomSmallButton extends StatelessWidget {
  const CustomSmallButton({
    super.key,
    this.text,
    this.icon,
    this.onTap,
  });
  final String? text;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff4985FF),
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Text(
                text!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                icon,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
