part of 'room_dashboard_cubit.dart';

@freezed
class RoomDashboardState with _$ChartState {
  const factory RoomDashboardState.initial() = Initial;
  const factory RoomDashboardState.loading() = Loading;
  const factory RoomDashboardState.loaded({
    List<List<RoomDashboardChartDataPointModel?>>? selectedPoints,
    List<double?>? averages,
  }) = Loaded;
  const factory RoomDashboardState.error(String message) = Error;
}
