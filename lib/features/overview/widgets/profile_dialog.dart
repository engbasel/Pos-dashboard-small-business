import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/func/check_lang.dart';
import 'package:pos_dashboard_v1/features/authentication/models/account_model.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.users});
  final List<Account> users;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 36,
          left: isArabic(context) ? 0 : null,
          right: isArabic(context) ? null : 0,
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            elevation: 3,
            shadowColor: Colors.grey,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * .25,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/profile picture.png',
                      height: 75,
                      width: 75,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      users.isEmpty ? '' : '${users[users.length - 1].name}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      users.isEmpty ? '' : users[users.length - 1].phone,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      users.isEmpty ? '' : users[users.length - 1].email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    // Row(
                    //   children: [
                    //     Text(
                    //       '${AppLocalizations.of(context).translate('Logged in at')} : ${DateTime.now()}',
                    //       style: const TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     // Text(
                    //     //   '${users[users.length - 1]} - ',
                    //     //   style: const TextStyle(
                    //     //     fontSize: 16,
                    //     //     fontWeight: FontWeight.w400,
                    //     //   ),
                    //     // ),
                    //     // Text(
                    //     //   '${users[users.length - 1]}',
                    //     //   style: const TextStyle(
                    //     //     fontSize: 16,
                    //     //     fontWeight: FontWeight.w400,
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
