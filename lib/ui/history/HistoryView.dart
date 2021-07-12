import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';
import 'package:kcal_counter_flutter/core/kiwi/KiwiInjector.dart';
import 'package:kcal_counter_flutter/ui/common/CustomCardView.dart';
import 'package:kcal_counter_flutter/ui/history/DaySummaryView.dart';
import 'package:kcal_counter_flutter/ui/history/HistoryCubit.dart';
import 'package:kcal_counter_flutter/ui/tools/GeneralUI.dart';

class HistoryViewCubit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            KiwiInjector.instance.getContainer().resolve<HistoryCubit>(),
        child: HistoryView());
  }
}

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
        builder: (constext, state) {
          if(state.loading) return GeneralUI.progressIndicator();
          else return _daysList(state.days!);
        },
        bloc: BlocProvider.of<HistoryCubit>(context));
  }

  Widget _daysList(List<Day> list) {
    return ListView.builder(itemBuilder: (context, position) {
      final day = list[position];
      return CustomCardView(child: DaySummaryView(day: day, key: ValueKey(day.id)));
    }, itemCount: list.length);
  }

}
