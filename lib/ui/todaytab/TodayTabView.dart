import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/ui/addconsumption/AddConsumptionView.dart';
import 'package:kcal_counter_flutter/ui/todaytab/ConsumtionListView.dart';
import 'package:kcal_counter_flutter/ui/todaytab/SummaryView.dart';
import 'package:kcal_counter_flutter/ui/tools/GeneralUI.dart';

import 'TodayViewCubit.dart';

class TodayTabViewBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            KiwiInjector.instance.getContainer().resolve<TodayViewCubit>(),
        child: TodayTabView());
  }
}

class TodayTabView extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<TodayViewCubit, TodayViewState>(
        bloc: BlocProvider.of<TodayViewCubit>(context),
        builder: (context, state) {
          if (state.loading) {
            return GeneralUI.progressIndicator();
          } else if (!state.isDayOpen) {
            return _dayNotOpenedBody(context);
          } else {
            return _body(context, state);
          }
        });
  }

  Widget _dayNotOpenedBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Center(
        child: Column(
          children: [
            Text("Pusto tutaj..."),
            TextButton(
                onPressed: () => _startDay(context),
                child: Text("Zacznij dzisiejszy dzień :)"))
          ],
        ),
      )),
    );
  }

  Widget _body(BuildContext context, TodayViewState state) {
    return Stack(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        state.consumptionSummary != null
            ? SummaryView(
                consumptionSummary: state.consumptionSummary!,
                key: ValueKey(state.consumptionSummary!.dayName))
            : Container(height: 0),
        Expanded(
            child: ConsumptionListView(
                key: ObjectKey(state.consumption),
                consumptions: state.consumption!))
      ]),
      _floatingActionButton(context, state.day!)
    ]);
  }

  Positioned _floatingActionButton(BuildContext context, Day day) {
    return Positioned(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _addConsumption(context, day),
        ),
      ),
      bottom: 10,
      right: 10,
    );
  }

  _startDay(BuildContext context) {
    BlocProvider.of<TodayViewCubit>(context).startDayToday();
  }

  void _addConsumption(BuildContext context, Day day) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            AddConsumptionViewPage(day: day, key: UniqueKey())));

    BlocProvider.of<TodayViewCubit>(context).reload();
  }
}
