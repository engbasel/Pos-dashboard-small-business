import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/user_Info/widgets/custom_label.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import '../../../core/utils/manager/manager.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class UserInfoSection extends StatefulWidget {
  const UserInfoSection({super.key});

  @override
  State<UserInfoSection> createState() => _UserInfoSectionState();
}

class _UserInfoSectionState extends State<UserInfoSection> {
  late Timer _timer;
  late String _currentDateTime;

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _timer = Timer.periodic(
        const Duration(seconds: 1), (timer) => _updateDateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateDateTime() {
    setState(() {
      _currentDateTime = _getCurrentDateTime();
    });
  }

  String _getCurrentDateTime() {
    final now = DateTime.now();
    final dayFormatter = DateFormat('EEEE');
    final dateTimeFormatter = DateFormat('MMM dd, yyyy hh:mm:ss a');
    return '${dayFormatter.format(now)}\n${dateTimeFormatter.format(now)}';
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Existing rows...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CustomLabel(
                  color: const Color(0xfff3e5f5),
                  labelValue:
                      appLocalizations.translate('time To day and time now'),
                  content: _currentDateTime,
                  imagename: ImagesManger.edit,
                ),
              ),
              Expanded(
                child: CustomLabel(
                  color: const Color(0xfffff2cc),
                  labelValue: appLocalizations.translate('Number of catigorys'),
                  content: '3',
                  imagename: ImagesManger.mail,
                ),
              ),
              Expanded(
                child: CustomLabel(
                  color: const Color(0xffe0f7fa),
                  labelValue:
                      appLocalizations.translate('total payments today'),
                  content: '\$1,234.56',
                  imagename: ImagesManger.shoppingbag,
                ),
              ),
              Expanded(
                child: CustomLabel(
                  color: const Color(0xffffebee),
                  labelValue:
                      appLocalizations.translate('Totoal Bill Exported today'),
                  content: '42',
                  imagename: ImagesManger.sex,
                ),
              ),
            ],
          ),
          // New rows for additional information
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomLabel(
                  color: const Color(0xffe8f5e9),
                  labelValue: appLocalizations
                      .translate('Totoal retuern prodatcs to day'),
                  content: 'John Doe - Cashier',
                  imagename: ImagesManger.sex,
                ),
              ),
              Expanded(
                child: CustomLabel(
                  color: const Color(0xfffff3e0),
                  labelValue: appLocalizations.translate('notifications'),
                  content: '3 new alerts',
                  imagename: ImagesManger.sex,
                ),
              ),
              Expanded(
                child: CustomLabel(
                  color: const Color(0xfffff3e0),
                  labelValue: appLocalizations.translate('notifications'),
                  content: '3 new alerts',
                  imagename: ImagesManger.sex,
                ),
              ),
            ],
          ),
          // Quick access buttons
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
