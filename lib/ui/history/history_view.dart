import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcal_counter_flutter/core/history/model/day.dart';
import 'package:kcal_counter_flutter/core/kiwi/kiwi_injector.dart';
import 'package:kcal_counter_flutter/ui/common/custom_card_view.dart';
import 'package:kcal_counter_flutter/ui/history/day_summary_view.dart';
import 'package:kcal_counter_flutter/ui/history/history_cubit.dart';
import 'package:kcal_counter_flutter/ui/tools/general_ui.dart';

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
        builder: (context, state) {
          if(state.loading) return Container();
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