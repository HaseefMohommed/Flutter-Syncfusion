import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../chart_page.dart';

part 'chart_cubit.freezed.dart';
part 'chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  ChartCubit() : super(const ChartState.initial());

  void loadInitialSelectedPointData() {
    try {
      emit(const ChartState.loading());

      emit(const ChartState.loaded(null));
    } catch (e) {
      emit(const ChartState.error('Failed to load chart data'));
    }
  }

  void updateSelectedPointData(ChartDataPoint? selectedPointData) {
    emit(ChartState.loaded(selectedPointData));
  }
}
