import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/func/check_lang.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/notification_item.dart';

class NotificationPopup extends StatelessWidget {
  const NotificationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 36,
          left: isArabic(context) ? 120 : null,
          right: isArabic(context) ? null : 120,
          child: AlertDialog(
            title: const Text('Notification'),
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.all(16),
            elevation: 3,
            shadowColor: Colors.grey,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .5,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    NotificationItem(
                        text: "You dont have enough products in the store"),
                    NotificationItem(text: "This item is needed"),
                    NotificationItem(text: "This item is needed"),
                    NotificationItem(text: "This item is needed"),
                    NotificationItem(text: "This item is needed"),
                    NotificationItem(text: "This item is needed"),
                    NotificationItem(text: "This item is needed"),
                    NotificationItem(text: "This item is needed"),
                    NotificationItem(text: "This item is needed"),
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
