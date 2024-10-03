import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syncfusion/chart_page.dart';
import 'package:flutter_syncfusion/cubit/chart_cubit.dart';

const Color primaryColor = Color(0xFF051638);
const Color buttonBorderColor = Color(0xFF338EDC);
const Color textColor = Color(0xFF338EDC);
final Color buttonBackgroundColor = const Color(0xFF338EDC).withOpacity(0.16);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChartCubit(),
      child: SafeArea(
        child: MaterialApp(
          title: 'Aroya Room Dashboard (Demo)',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // scaffoldBackgroundColor: const Color(0xFF0E2039),
            scaffoldBackgroundColor: primaryColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
          home: const DashboardPage(),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<ChartSeriesData>> chartSeries = [
      generateChartSeries(seriesCount: 3, setIndex: 1),
      generateChartSeries(seriesCount: 3, setIndex: 2),
      generateChartSeries(seriesCount: 3, setIndex: 3),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aroya Charts Sample'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChartPage(
                  chartSeries: chartSeries,
                ),
              ),
            );
          },
          child: const Text('Room Dashboard'),
        ),
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
