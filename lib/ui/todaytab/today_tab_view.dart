import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/history/model/consumption.dart';
import 'package:kcal_counter_flutter/core/history/model/day.dart';
import 'package:kcal_counter_flutter/core/kiwi/kiwi_injector.dart';
import 'package:kcal_counter_flutter/ui/addconsumption/add_consumption_view.dart';
import 'package:kcal_counter_flutter/ui/todaytab/consumption_list_view.dart';
import 'package:kcal_counter_flutter/ui/todaytab/summary_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'today_view_cubit.dart';

class TodayTabViewBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            KiwiInjector.instance.getContainer().resolve<TodayViewCubit>(),
        child: TodayTabView());
  }
}

class TodayTabView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodayTabViewState();
}

class TodayTabViewState extends State<TodayTabView> implements ConsumptionListListener {

  Widget build(BuildContext context) {
    return BlocBuilder<TodayViewCubit, TodayViewState>(
        bloc: BlocProvider.of<TodayViewCubit>(context),
        builder: (context, state) {
          if (state.loading) {
            return Container();
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
                Text(AppLocalizations.of(context)!.summaryLabelEmpty),
                TextButton(
                    onPressed: () => _startDay(context),
                    child: Text(AppLocalizations.of(context)!.summaryLabelStartNewDay))
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
            key: UniqueKey())
            : Container(height: 0),
        Expanded(
            child: ConsumptionListView(
              key: UniqueKey(),
              consumptions: state.consumption!, listener: this))
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

  @override
  void deleteConsumptionClicked(Consumption consumption) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.summaryConfirmDeleteTitle),
      content: Text(AppLocalizations.of(context)!.summaryConfirmDeleteContent("${consumption.name} / ${consumption.amount} [${consumption.calculationUnit}]")),
      actions: [
        TextButton(onPressed: ()  {
          _deleteConsumption(this.context, consumption);
          Navigator.of(this.context).pop();
        }, child: Text(AppLocalizations.of(context)!.commonYes)),
        TextButton(onPressed: ()  {
          Navigator.of(this.context).pop();
        }, child: Text(AppLocalizations.of(context)!.commonNo)),
      ],
    ));
  }


  _deleteConsumption(BuildContext context, Consumption consumption) async {
    await BlocProvider.of<TodayViewCubit>(context).delete(consumption);

    _refresh();
  }

  void _refresh() async {
    BlocProvider.of<TodayViewCubit>(context).reload();
  }

  @override
  void consumptionClicked(Consumption consumption) {
    //todo
  }

}
