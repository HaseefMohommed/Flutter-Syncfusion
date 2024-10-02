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
    return const MaterialApp(
      title: 'Flutter Syncfusion Demo',
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static List<ChartData> generateChartData(int count) {
    final random = Random();
    final List<ChartData> data = [];
    final startDate = DateTime(2024, 1, 1);
    final endDate = DateTime(2024, 2, 1);

    for (int i = 0; i < count; i++) {
      final progress = i / (count - 1);
      final currentDate = startDate.add(Duration(
          milliseconds:
              (endDate.difference(startDate).inMilliseconds * progress)
                  .round()));

      final firstValue = (random.nextDouble() * 10).toStringAsFixed(1);
      final secondValue = (random.nextDouble() * 10).toStringAsFixed(1);
      final thirdValue = (random.nextDouble() * 10).toStringAsFixed(1);

      data.add(ChartData(currentDate, double.parse(firstValue),
          double.parse(secondValue), double.parse(thirdValue)));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = generateChartData(1000);

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
                  chartData: chartData,
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
