import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/ui/settingstab/SettingsTabCubit.dart';
import 'package:kcal_counter_flutter/ui/tools/GeneralUI.dart';
import 'package:kcal_counter_flutter/ui/tools/SnackbarHelper.dart';
import 'package:kcal_counter_flutter/ui/widget/SettingsButton.dart';

class SettingsTabViewCubit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => KiwiInjector.instance
            .getContainer()
            .resolve<SettingsTabCubit>(),
        child: SettingsTabView());
  }
}

class SettingsTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsTabCubit, SettingsTabState>(builder: (context, state) {
      if(state.loading) return GeneralUI.progressIndicator();

      if(state.error != null) {
        SnackbarHelper.error(context, state.error!);
      }

      if(state.success != null) {
        SnackbarHelper.green(context, state.success!);
      }

      return _body(context);
    }, bloc: BlocProvider.of<SettingsTabCubit>(context));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        SettingsButton(text: "Wyczyść tabelę kalori", listener: () => _clearLibrary(context)),
        SettingsButton(text: "Exportuj tabelę do CSV", listener: () => _exportLibrary(context)),
        SettingsButton(text: "Importuj tabelę z CSV", listener: () => _importLibraryFromCsv(context)),
        SettingsButton(text: "Jak zbudować plik CSV?", listener: () => _csvHelp(context)),
        SettingsButton(text: "Licencja", listener: () => _license(context)),
        SettingsButton(text: "Credits & info", listener: () => _credits(context)),
      ],
    );
  }

  _clearLibrary(BuildContext context) {
    final parentContext = context;
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Czy na pewno wyczyścić tabelę kalorii?"),
      content: Text("Czy na pewno usunąć wszystkie wpisy z tabeli kalori? TEJ OPERACJI NIE DA SIĘ ODWRÓCIC"),
      actions: [
        TextButton(onPressed: ()  {
          BlocProvider.of<SettingsTabCubit>(parentContext).deleteLibrary();
          Navigator.of(context).pop();
        }, child: Text("Tak")),
        TextButton(onPressed: ()  {
          Navigator.of(context).pop();
        }, child: Text("Nie")),
      ],
    ));
  }

  _exportLibrary(BuildContext context) {
    BlocProvider.of<SettingsTabCubit>(context).exportLibraryAsCsv();
  }

  _importLibraryFromCsv(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        withData: true
      );

      if (result != null && result.files.isNotEmpty == true) {
        final file = result.files[0];
        BlocProvider.of<SettingsTabCubit>(context).importLibrary(file);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  _csvHelp(BuildContext context) {}

  _license(BuildContext context) {}

  _credits(BuildContext context) {}

}
