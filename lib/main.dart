import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/chart_page.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Syncfusion Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0E2039),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static List<ChartSeries> generateChartSeries({int seriesCount = 5}) {
    final random = Random();

    final startDate = DateTime(2024, 1, 1);
    final endDate = DateTime(2024, 1, 31);

    List<ChartSeries> chartSeries = List.generate(seriesCount, (seriesIndex) {
      final color = Color.lerp(Colors.blue[900]!, Colors.blue[100]!,
          seriesIndex / (seriesCount - 1))!;

      return generateSeries(startDate, endDate, 'Series ${seriesIndex + 1}',
          color, (progress) => generateRandomValue(progress, random));
    });

    return chartSeries;
  }

  static ChartSeries generateSeries(DateTime startDate, DateTime endDate,
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

    return ChartSeries(
      name: name,
      color: color,
      data: dataPoints,
    );
  }

  static double generateRandomValue(double progress, Random random) {
    double value = 35 + 15 * sin(progress * 2 * pi * 3);

    value += random.nextDouble() * 4 - 2;

    return value.clamp(15, 55);
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartSeries> chartSeries = generateChartSeries(seriesCount: 10);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
          child: const Text('View Chart'),
        ),
      ),
    );
  }
}
