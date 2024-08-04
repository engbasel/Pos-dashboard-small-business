import 'package:flutter/material.dart';

class NoNeededProdact extends StatelessWidget {
  const NoNeededProdact({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
              color: const Color(0xff4680f5),
              borderRadius: BorderRadius.circular(12)),
          child: const Center(
              child: Text(
            'No Needed prodacts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ))),
    );
  }
}
