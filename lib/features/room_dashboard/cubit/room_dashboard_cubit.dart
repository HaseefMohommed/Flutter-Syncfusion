import 'package:bloc/bloc.dart';
import 'package:flutter_syncfusion/features/room_dashboard/models/room_dashboard_chart_data_point_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_cubit.freezed.dart';
part 'room_dashboard_state.dart';

class RoomDashboardCubit extends Cubit<RoomDashboardState> {
  RoomDashboardCubit() : super(const RoomDashboardState.initial());

  void loadInitialSelectedPointData() {
    try {
      emit(const RoomDashboardState.loading());

      emit(const RoomDashboardState.loaded(
        averages: null,
        selectedPoints: null,
      ));
    } catch (e) {
      emit(const RoomDashboardState.error('Failed to load chart data'));
    }
  }

  void updateAveragePointData(List<double> averages) {
    emit(RoomDashboardState.loaded(
      averages: averages,
      selectedPoints: null,
    ));
  }
}
