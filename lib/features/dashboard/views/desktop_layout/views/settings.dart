import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../../l10n/ocale_provider.dart';
import '../../../../login/views/user_logs_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
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
              AppLocalizations.of(context).translate('anotherSettingOption')),
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
            // Handle onPressed for staff data
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
            _showLanguageDialog(context);
          },
        ),
        const Divider(),
        // Add more ListTiles for additional settings
      ],
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('changeLanguage')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('English'),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(const Locale('en'));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('العربية'),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(const Locale('ar'));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
