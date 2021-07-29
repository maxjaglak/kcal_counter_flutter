import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kcal_counter_flutter/appconfig/LocalisationConfigProvider.dart';
import 'package:kcal_counter_flutter/ui/init/InitView.dart';
import 'appconfig/ThemeDataProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: ThemeDataProvider.themeData(),
      localizationsDelegates:
          LocalisationConfigProvider.localisationDelegates(),
      supportedLocales: LocalisationConfigProvider.supportedLocales(),
      home: InitViewBloc(),
    );
  }
}
