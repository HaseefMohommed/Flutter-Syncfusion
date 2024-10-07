import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/main.dart';

import '../chart/pages/chart_page.dart';
import 'custom_bottom_sheet.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  static List<List<ChartSeriesData>> chartSeries = [
    generateChartSeries(seriesCount: 3, setIndex: 1),
    generateChartSeries(seriesCount: 3, setIndex: 2),
    generateChartSeries(seriesCount: 3, setIndex: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aroya Sample'.toUpperCase(),
          style: const TextStyle(
            color: iconColor,
            fontWeight: FontWeight.w300,
            fontSize: 16,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/png/dashboard_sample_screenshot.png',
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: CustomBottomSheet()),
            ],
          ),
        ],
      ),
    );
  }

  static List<ChartSeriesData> generateChartSeries({
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

    List<ChartSeriesData> chartSeries =
        List.generate(seriesCount, (seriesIndex) {
      double lightness = 0.4 + (seriesIndex / (seriesCount - 1)) * 0.4;

      Color color = HSLColor.fromColor(baseColor.withOpacity(1.0))
          .withLightness(lightness)
          .toColor();

      return generateSeries(
        startDate,
        endDate,
        'Set $setIndex Series ${seriesIndex + 1}',
        color,
        (progress) => generateDistinctRandomValue(progress, setIndex),
      );
    });

    return chartSeries;
  }

  static double generateDistinctRandomValue(double progress, int setIndex) {
    final random = Random();
    double value;

    value = (20 * setIndex) + 15 + 10 * sin(progress * 2 * pi * (setIndex + 2));

    value += random.nextDouble() * (setIndex + 1) * 5 - (setIndex + 1) * 2.5;

    return value.clamp(15, 100);
  }

  static ChartSeriesData generateSeries(DateTime startDate, DateTime endDate,
      String name, Color color, double Function(double) valueGenerator) {
    final dataPoints = List.generate(100, (i) {
      final progress = i / 99;

      final currentDate = startDate.add(Duration(
          milliseconds:
              (endDate.difference(startDate).inMilliseconds * progress)
                  .round()));

      final value = valueGenerator(progress);

      return ChartDataPoint(currentDate, value);
    });

    return ChartSeriesData(
      name: name,
      color: color,
      data: dataPoints,
    );
  }

  static double generateRandomValue(double progress) {
    final random = Random();
    double value = 35 + 15 * sin(progress * 2 * pi * 3);

    value += random.nextDouble() * 4 - 2;

    return value.clamp(15, 55);
  }
}
