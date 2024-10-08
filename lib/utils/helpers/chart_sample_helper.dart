import 'dart:math';

import 'package:flutter/material.dart';

import '../../features/room_dashboard/models/room_dashboard_chart_data_point_model.dart';
import '../../features/room_dashboard/models/room_dashboard_chart_series_data_model.dart';

class ChartSampleHelper {
  static List<List<RoomDashboardChartSeriesDataModel>> chartSeries = [
    _generateChartSeries(seriesCount: 3, setIndex: 1),
    _generateChartSeries(seriesCount: 3, setIndex: 2),
    _generateChartSeries(seriesCount: 3, setIndex: 3),
  ];

  static List<RoomDashboardChartSeriesDataModel> _generateChartSeries({
    int seriesCount = 5,
    required int setIndex,
  }) {
    final startDate = DateTime(2024, 1, 1);
    final endDate = DateTime(2024, 1, 14);

    List<Color> baseColors = [
      Colors.brown,
      Colors.cyan,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.pink,
      Colors.blue,
      Colors.yellow,
      Colors.teal,
      Colors.red,
    ];

    assert(setIndex - 1 < baseColors.length, 'No base color for this setIndex');

    Color baseColor = baseColors[setIndex - 1];

    List<RoomDashboardChartSeriesDataModel> chartSeries =
        List.generate(seriesCount, (seriesIndex) {
      double lightness = 0.4 + (seriesIndex / (seriesCount - 1)) * 0.4;

      Color color = HSLColor.fromColor(baseColor.withOpacity(1.0))
          .withLightness(lightness)
          .toColor();

      return _generateSeries(
        startDate,
        endDate,
        'Set $setIndex Series ${seriesIndex + 1}',
        color,
        (progress) => _generateDistinctRandomValue(progress, setIndex),
      );
    });

    return chartSeries;
  }

  static RoomDashboardChartSeriesDataModel _generateSeries(
      DateTime startDate,
      DateTime endDate,
      String name,
      Color color,
      double Function(double) valueGenerator) {
    final dataPoints = List.generate(100, (i) {
      final progress = i / 99;

      final currentDate = startDate.add(Duration(
          milliseconds:
              (endDate.difference(startDate).inMilliseconds * progress)
                  .round()));

      final value = valueGenerator(progress);

      return RoomDashboardChartDataPointModel(currentDate, value);
    });

    return RoomDashboardChartSeriesDataModel(
      name: name,
      color: color,
      data: dataPoints,
    );
  }

  static double _generateDistinctRandomValue(double progress, int setIndex) {
    final random = Random();
    double value;

    value = (20 * setIndex) + 15 + 10 * sin(progress * 2 * pi * (setIndex + 2));

    value += random.nextDouble() * (setIndex + 1) * 5 - (setIndex + 1) * 2.5;

    return value.clamp(15, 100);
  }

  static double _generateRandomValue(double progress) {
    final random = Random();
    double value = 35 + 15 * sin(progress * 2 * pi * 3);

    value += random.nextDouble() * 4 - 2;

    return value.clamp(15, 55);
  }
}
