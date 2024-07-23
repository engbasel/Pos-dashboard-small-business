import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class Catigorysscreen extends StatelessWidget {
  const Catigorysscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            " ${AppLocalizations.of(context).translate('catigoryscreen')}"),
      ),
      body: const Column(
        children: [CoustomCatigoryCard()],
      ),
    );
  }
}

class CoustomCatigoryCard extends StatelessWidget {
  const CoustomCatigoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('Catigory One'),
      ),
    );
  }
}
