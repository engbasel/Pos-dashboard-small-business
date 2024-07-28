import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/function_manger.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';

import '../../../l10n/app_localizations.dart';
import '../../login/views/user_logs_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(title: 'Settings'),
        const SizedBox(height: 16),
        ListTile(
          title: Text(AppLocalizations.of(context).translate('viewUserLogs')),
          leading: const Icon(Icons.history),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserLogsView()),
            );
          },
        ),
        const Divider(),
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate('anotherSettingOption'),
          ),
          leading: const Icon(Icons.settings),
          onTap: () {
            // Handle onPressed for another setting option
          },
        ),
        const Divider(),
        ListTile(
          title: Text(AppLocalizations.of(context).translate('staff')),
          leading: const Icon(Icons.people),
          onTap: () {
            showPasswordAdminDialog(context);
          },
        ),
        const Divider(),
        ListTile(
          title: Text(AppLocalizations.of(context).translate('users')),
          leading: const Icon(Icons.person),
          onTap: () {
            // Handle onPressed for users data
          },
        ),
        const Divider(),
        ListTile(
          title: Text(AppLocalizations.of(context).translate('changeMode')),
          leading: const Icon(Icons.brightness_4),
          onTap: () {
            // Handle onPressed for changing app mode
          },
        ),
        const Divider(),
        ListTile(
          title: Text(AppLocalizations.of(context).translate('changeLanguage')),
          leading: const Icon(Icons.language),
          onTap: () {
            showChangeLanguageDialog(context);
          },
        ),
        const Divider(),
        // Add more ListTiles for additional settings
      ],
    );
  }
}
