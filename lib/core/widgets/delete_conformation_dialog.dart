import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class DeleteConformationDialog extends StatelessWidget {
  const DeleteConformationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Text(
        AppLocalizations.of(context).translate('confirmDeleteMessage'),
        style: const TextStyle(fontSize: 19),
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            AppLocalizations.of(context).translate('delete'),
          ),
        ),
        MaterialButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            AppLocalizations.of(context).translate('cancel'),
          ),
        ),
      ],
    );
  }
}
