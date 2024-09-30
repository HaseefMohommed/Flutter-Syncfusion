import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatelessWidget {
  ChartPage({super.key});

  final List<ChartData> chartData = [
    ChartData(DateTime(2024, 1, 18), 0.5, 2.0, 1.0),
    ChartData(DateTime(2024, 1, 19), 9.8, 3.2, 5.5),
    ChartData(DateTime(2024, 1, 20), 4.2, 8.8, 4.8),
    ChartData(DateTime(2024, 1, 21), 5.8, 4.3, 2.2),
    ChartData(DateTime(2024, 1, 22), 3.8, 0.7, 3.3),
    ChartData(DateTime(2024, 1, 23), 6.5, 2.5, 4.0),
    ChartData(DateTime(2024, 1, 24), 7.2, 3.7, 6.1),
    ChartData(DateTime(2024, 1, 25), 1.4, 5.5, 2.7),
    ChartData(DateTime(2024, 1, 26), 8.0, 6.2, 5.8),
    ChartData(DateTime(2024, 1, 27), 4.9, 7.3, 6.4),
    ChartData(DateTime(2024, 1, 28), 3.6, 8.5, 7.1),
    ChartData(DateTime(2024, 1, 29), 5.0, 2.9, 3.8),
    ChartData(DateTime(2024, 1, 30), 6.7, 4.1, 5.0),
    ChartData(DateTime(2024, 1, 31), 7.9, 5.6, 6.9),
    ChartData(DateTime(2024, 2, 1), 2.3, 1.8, 1.4),
    ChartData(DateTime(2024, 2, 2), 3.1, 3.0, 2.7),
    ChartData(DateTime(2024, 2, 3), 4.5, 7.9, 5.5),
    ChartData(DateTime(2024, 2, 4), 6.0, 4.8, 3.4),
    ChartData(DateTime(2024, 2, 5), 2.7, 5.2, 4.3),
    ChartData(DateTime(2024, 2, 6), 9.0, 6.1, 7.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(
            builder: (context, constraints) {
              double chartHeight = orientation == Orientation.portrait
                  ? constraints.maxHeight * 0.4
                  : constraints.maxHeight;
              double chartWidth = constraints.maxWidth;

              return Column(
                children: [
                  SizedBox(
                    height: chartHeight,
                    width: chartWidth,
                    child: SfCartesianChart(
                      title: const ChartTitle(text: 'Flutter chart'),
                      primaryXAxis: DateTimeAxis(
                        majorGridLines: const MajorGridLines(),
                        axisLine: const AxisLine(width: 0),
                        dateFormat: DateFormat.MMMd(),
                        intervalType: DateTimeIntervalType.days,
                        interval: 5,
                      ),
                      primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: 10,
                        interval: 2,
                        majorGridLines: MajorGridLines(
                          width: 0.5,
                          color: Colors.grey[300],
                        ),
                        axisLine: const AxisLine(width: 1),
                      ),
                      series: <CartesianSeries>[
                        SplineSeries<ChartData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.date,
                          yValueMapper: (ChartData data, _) => data.firstValue,
                          color: Colors.green,
                        ),
                        SplineSeries<ChartData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.date,
                          yValueMapper: (ChartData data, _) => data.secondValue,
                          color: Colors.blue,
                        ),
                        SplineSeries<ChartData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.date,
                          yValueMapper: (ChartData data, _) => data.thirdValue,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class ChartData {
  final DateTime date;
  final double firstValue;
  final double secondValue;
  final double thirdValue;

  ChartData(
    this.date,
    this.firstValue,
    this.secondValue,
    this.thirdValue,
  );
}
