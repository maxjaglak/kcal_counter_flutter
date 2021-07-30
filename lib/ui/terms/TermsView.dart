import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kcal_counter_flutter/ui/init/InitBloc.dart';

class TermsViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.termsTitle),
      ),
      body: SafeArea(
        child: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.termsContent),
            Container(height: 10),
            Text(
              AppLocalizations.of(context)!.termsDisclaimer,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Container(height: 10),
            Text(AppLocalizations.of(context)!.termsPrivacy),
            Container(height: 10),
            TextButton(
                onPressed: () => _agree(context),
                child: Text(AppLocalizations.of(context)!.termsAgreeButton))
          ],
        ),
      ),
    );
  }

  _agree(BuildContext context) {
    BlocProvider.of<InitBloc>(context).add(TermsAcceptedEvent());
  }
}
