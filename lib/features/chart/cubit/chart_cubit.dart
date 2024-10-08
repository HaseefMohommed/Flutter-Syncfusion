import 'package:bloc/bloc.dart';
import 'package:flutter_syncfusion/features/chart/chart_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_cubit.freezed.dart';
part 'chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  ChartCubit() : super(const ChartState.initial());

  void loadInitialSelectedPointData() {
    try {
      emit(const ChartState.loading());

      emit(const ChartState.loaded(
        averages: null,
        selectedPoints: null,
      ));
    } catch (e) {
      emit(const ChartState.error('Failed to load chart data'));
    }
  }

  void updateAveragePointData(List<double> averages) {
    emit(ChartState.loaded(
      averages: averages,
      selectedPoints: null,
    ));
  }
}
