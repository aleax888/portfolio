import 'package:flutter/services.dart';

Future<void> loadPortfolioFonts() async {
  for (final entry in {
    'BebasNeue': 'bebas_neue',
    'FragmentMono': 'fragment_mono',
    'Inter': 'inter',
  }.entries) {
    final loader = FontLoader(entry.key)
      ..addFont(rootBundle.load('assets/fonts/${entry.value}_regular.ttf'));
    await loader.load();
  }
}
