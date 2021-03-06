import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/kiwi/kiwi_injector.dart';
import 'package:kcal_counter_flutter/ui/view_view_page.dart';
import 'package:kcal_counter_flutter/ui/settingstab/settings_tab_cubit.dart';
import 'package:kcal_counter_flutter/ui/tools/general_ui.dart';
import 'package:kcal_counter_flutter/ui/tools/snackbar_helper.dart';
import 'package:kcal_counter_flutter/ui/widget/settings_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTabViewCubit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            KiwiInjector.instance.getContainer().resolve<SettingsTabCubit>(),
        child: SettingsTabView());
  }
}

class SettingsTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsTabCubit, SettingsTabState>(
        builder: (context, state) {
          if (state.loading) return GeneralUI.progressIndicator();

          if (state.error != null) {
            SnackbarHelper.error(context, state.error!);
          }

          if (state.success != null) {
            _displaySuccessMessage(context, state);
          }

          return _body(context);
        },
        bloc: BlocProvider.of<SettingsTabCubit>(context));
  }

  void _displaySuccessMessage(BuildContext context, SettingsTabState state) {
    var message = "";
    switch (state.success) {
      case SuccessMessage.ImportFinished:
        message = AppLocalizations.of(context)!.settingsMessageImportFinished;
        break;
      case SuccessMessage.Deleted:
        message = AppLocalizations.of(context)!.settingsMessageLibraryDeleted;
        break;
      case null:
        return;
    }
    SnackbarHelper.green(context, message);
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        SettingsButton(
            text: AppLocalizations.of(context)!.settingsLabelClearLibrary,
            listener: () => _clearLibrary(context)),
        SettingsButton(
            text: AppLocalizations.of(context)!.settingsLabelExportLibraryToCsv,
            listener: () => _exportLibrary(context)),
        SettingsButton(
            text:
                AppLocalizations.of(context)!.settingsLabelImportLibraryFromCsv,
            listener: () => _importLibraryFromCsv(context)),
        SettingsButton(
            text: AppLocalizations.of(context)!.settingsLabelHowToBuildCsvFile,
            listener: () => _csvHelp(context)),
        SettingsButton(
            text: AppLocalizations.of(context)!.settingsLabelLicense,
            listener: () => _license(context)),
        SettingsButton(
            text: AppLocalizations.of(context)!.settingsLabelCreditsAndInfo,
            listener: () => _credits(context)),
      ],
    );
  }

  _clearLibrary(BuildContext context) {
    final parentContext = context;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!
                  .settingsConfirmClearLibraryTitle),
              content: Text(AppLocalizations.of(context)!
                  .settingsConfirmClearLibraryContent),
              actions: [
                TextButton(
                    onPressed: () {
                      BlocProvider.of<SettingsTabCubit>(parentContext)
                          .deleteLibrary();
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.commonYes)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.commonNo)),
              ],
            ));
  }

  _exportLibrary(BuildContext context) {
    BlocProvider.of<SettingsTabCubit>(context).exportLibraryAsCsv();
  }

  _importLibraryFromCsv(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.any, withData: true);

      if (result != null && result.files.isNotEmpty == true) {
        final file = result.files[0];
        BlocProvider.of<SettingsTabCubit>(context).importLibrary(file);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  _csvHelp(BuildContext context) {
    String resource;
    if (Platform.isAndroid) {
      resource =
          AppLocalizations.of(context)!.csvTutorialResourceNameAndroid;
    } else {
      resource = AppLocalizations.of(context)!.csvTutorialResourceName;
    }
    _openWebView(context, resource,
        AppLocalizations.of(context)!.settingsLabelHowToBuildCsvFile);
  }

  _license(BuildContext context) {
    String resource;
    if (Platform.isAndroid) {
      resource = "assets/html/license_android.html";
    } else {
      resource = "assets/html/license.html";
    }
    _openWebView(
        context, resource, AppLocalizations.of(context)!.settingsLabelLicense);
  }

  _credits(BuildContext context) {
    String resource;
    if (Platform.isAndroid) {
      resource = "assets/html/credits_and_info_android.html";
    } else {
      resource = "assets/html/credits_and_info.html";
    }
    _openWebView(context, resource,
        AppLocalizations.of(context)!.settingsLabelCreditsAndInfo);
  }

  _openWebView(BuildContext context, String asset, String title) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WebViewPage(asset: asset, title: title)));
  }
}
