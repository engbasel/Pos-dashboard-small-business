import 'package:flutter/material.dart';

class label_Info_card extends StatelessWidget {
  String typeofLabel;
  String image;
  String contentoflabel;
  int ColorValue;

  label_Info_card({
    super.key,
    required this.typeofLabel,
    required this.image,
    required this.contentoflabel,
    required this.ColorValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffe3ebee), width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(ColorValue),
            ),
            child: Center(child: Image.asset(image, width: 24, height: 24)),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(typeofLabel,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 4),
              Text(contentoflabel, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
