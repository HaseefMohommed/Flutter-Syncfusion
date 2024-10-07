part of 'chart_cubit.dart';

@freezed
class ChartState with _$ChartState {
  const factory ChartState.initial() = Initial;
  const factory ChartState.loading() = Loading;
  const factory ChartState.loaded({
    List<List<ChartDataPoint?>>? selectedPoints,
    List<double?>? averages,
  }) = Loaded;
  const factory ChartState.error(String message) = Error;
}
