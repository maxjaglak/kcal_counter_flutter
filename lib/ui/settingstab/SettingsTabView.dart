import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/ui/settingstab/SettingsTabCubit.dart';
import 'package:kcal_counter_flutter/ui/tools/GeneralUI.dart';
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

      else return _body(context);
    }, bloc: BlocProvider.of<SettingsTabCubit>(context));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        SettingsButton(text: "Wyczyść tabelę kalori", listener: () => _clearLibrary(context)),
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

}
