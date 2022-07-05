import 'package:bloc/bloc.dart';
import 'package:kcal_counter_flutter/core/history/dao/day_dao.dart';
import 'package:kcal_counter_flutter/core/history/model/day.dart';

class HistoryCubit extends Cubit<HistoryState> {

  final DayDao dayDao;

  HistoryCubit(this.dayDao) : super(HistoryState(loading: true)) {
    reload();
  }

  void reload() async {
    emit(HistoryState(loading: true));
    final days = await dayDao.getDays();
    emit(HistoryState(loading: false, days: days));
  }

}

class HistoryState {
  final bool loading;
  final List<Day>? days;

  HistoryState({this.loading = false, this.days});

}