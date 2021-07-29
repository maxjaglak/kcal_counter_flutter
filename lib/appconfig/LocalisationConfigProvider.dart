import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalisationConfigProvider {
  static List<LocalizationsDelegate<dynamic>> localisationDelegates() {
    return [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }

  static List<Locale> supportedLocales() {
    return [
      Locale('en', ''),
      Locale('pl', ''),
    ];
  }
}
