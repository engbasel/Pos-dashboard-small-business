// import 'package:flutter/material.dart';

// class TotalPointAndOrdersAndVisetsCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final String subValue;
//   final String subValuetwo;
//   final String subTitle;
//   final int numberOfProductsInStore; // Change to int
//   final IconData icon;
//   final Color color;

//   const TotalPointAndOrdersAndVisetsCard({
//     super.key,
//     required this.title,
//     required this.value,
//     this.subValue = '',
//     this.subValuetwo = '',
//     this.subTitle = '',
//     required this.numberOfProductsInStore, // Required
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: const Color(0xffe3ebee), width: 1),
//       ),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(icon, color: color, size: 30),
//                   const SizedBox(width: 8),
//                   Text(
//                     title,
//                     style: const TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     '$numberOfProductsInStore', // Display as string
//                     style:
//                         const TextStyle(fontSize: 13, color: Color(0xFF2CC56F)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xff37474F),
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 subValuetwo,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.normal,
//                   color: Color(0xff37474F),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 subTitle,
//                 style:
//                     const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 subValue,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.normal,
//                   color: Color(0xff37474F),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class TotalPointAndOrdersAndVisetsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subValue;
  final String subValuetwo;
  final String subTitle;
  final int numberOfProductsInStore;
  final IconData icon;
  final Color color;

  const TotalPointAndOrdersAndVisetsCard({
    super.key,
    required this.title,
    required this.value,
    this.subValue = '',
    this.subValuetwo = '',
    this.subTitle = '',
    required this.numberOfProductsInStore,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    style:
                        const TextStyle(fontSize: 13, color: Color(0xFF2CC56F)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff37474F),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                subValuetwo,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff37474F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subTitle,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                subValue,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff37474F),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
