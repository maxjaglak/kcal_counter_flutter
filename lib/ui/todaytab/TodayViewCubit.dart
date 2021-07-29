import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:kcal_counter_flutter/core/history/ConsumptionService.dart';
import 'package:kcal_counter_flutter/core/history/model/Consumption.dart';
import 'package:kcal_counter_flutter/core/history/model/ConsumptionSummary.dart';
import 'package:kcal_counter_flutter/core/history/model/Day.dart';

class TodayViewCubit extends Cubit<TodayViewState> {
  final ConsumptionService consumptionService;

  TodayViewCubit(this.consumptionService)
      : super(TodayViewState(loading: true)) {
    reload();
  }

  void reload() async {
    final Day? currentDay = await consumptionService.getTodayDay();

    if (currentDay == null) {
      emit(TodayViewState(isDayOpen: false));
      return;
    }

    final list = await consumptionService.getConsumptionForDay(currentDay.id!);
    final summary =
        await consumptionService.getCosumptionSummaryForDay(currentDay.id!);

    emit(TodayViewState(
        isDayOpen: true,
        day: currentDay,
        consumption: list,
        consumptionSummary: summary));
  }

  Future<void> startDayToday() async {
    await consumptionService.openDay();
    reload();
  }

  Future<void> delete(Consumption consumption) async {
    await consumptionService.deleteConsumption(consumption);
  }
}

class TodayViewState {
  final bool loading;
  final bool isDayOpen;
  final Day? day;
  final List<Consumption>? consumption;
  final ConsumptionSummary? consumptionSummary;

  TodayViewState(
      {this.day,
      this.consumption,
      this.consumptionSummary,
      this.isDayOpen = false,
      this.loading = false});
}
