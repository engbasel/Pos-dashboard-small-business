import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/userInformation/widgets/custom_label.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

import '../../../core/utils/manager/manager.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CustomLabel(
                  color: const Color(0xfffff2cc),
                  labelValue: appLocalizations.translate('email'),
                  content: 'abcd123@gmail.com',
                  imagename: ImagesManger.mail,
                ),
              ),
              Expanded(
                child: CustomLabel(
                  color: const Color(0xfff3e5f5),
                  labelValue: appLocalizations.translate('registerSince'),
                  content: 'Aug 22, 2022',
                  imagename: ImagesManger.edit,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomLabel(
                  color: const Color(0xffe0f7fa),
                  labelValue: appLocalizations.translate('favouriteBranch'),
                  content: 'Branch A',
                  imagename: ImagesManger.agency,
                ),
              ),
              Expanded(
                child: CustomLabel(
                  color: const Color(0xffffebee),
                  labelValue: appLocalizations.translate('favouriteItem'),
                  content: 'Pizza',
                  imagename: ImagesManger.shoppingbag,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
