import 'package:flutter/material.dart';

class UserInfoScetion extends StatelessWidget {
  const UserInfoScetion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                // width: 50,
                // height: 50,
                color: const Color(0xffe0f8ea),
                child: const Row(
                  children: [
                    Column(
                      children: [
                        Text('Email'),
                        Text('abcd123@gmail.com'),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                // width: 50,
                // height: 50,
                color: const Color(0xffe0f8ea),
                child: const Row(
                  children: [
                    Column(
                      children: [
                        Text('Email'),
                        Text('abcd123@gmail.com'),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                // width: 50,
                // height: 50,
                color: const Color(0xffe0f8ea),
                child: const Row(
                  children: [
                    Column(
                      children: [
                        Text('Email'),
                        Text('abcd123@gmail.com'),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                // width: 50,
                // height: 50,
                color: const Color(0xffe0f8ea),
                child: const Row(
                  children: [
                    Column(
                      children: [
                        Text('Email'),
                        Text('abcd123@gmail.com'),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
