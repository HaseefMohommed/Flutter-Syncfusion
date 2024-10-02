import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatelessWidget {
  final List<ChartData> chartData;

  const ChartPage({
    super.key,
    required this.chartData,
  });

  (int, int) getMinMaxValues() {
    double minValue = double.infinity;
    double maxValue = double.negativeInfinity;

    for (var data in chartData) {
      minValue = [data.firstValue, data.secondValue, data.thirdValue, minValue]
          .reduce((a, b) => a < b ? a : b);
      maxValue = [data.firstValue, data.secondValue, data.thirdValue, maxValue]
          .reduce((a, b) => a > b ? a : b);
    }

    return (
      minValue.floor(),
      maxValue.ceil(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (minYValue, maxYValue) = getMinMaxValues();

    return Scaffold(
      appBar: AppBar(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(
            builder: (context, constraints) {
              double chartHeight = orientation == Orientation.portrait
                  ? constraints.maxHeight * 0.6
                  : constraints.maxHeight;
              double chartWidth = constraints.maxWidth;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: chartHeight,
                      width: chartWidth,
                      child: SfCartesianChart(
                        title: const ChartTitle(
                          text: 'Flutter chart',
                        ),
                        zoomPanBehavior: ZoomPanBehavior(
                          enablePinching: true,
                          enableDoubleTapZooming: true,
                          enablePanning: true,
                          zoomMode: ZoomMode.x,
                        ),
                        primaryXAxis: DateTimeAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          axisLine: const AxisLine(width: 1),
                          dateFormat: DateFormat.MMMd(),
                          intervalType: DateTimeIntervalType.auto,
                        ),
                        primaryYAxis: NumericAxis(
                          minimum: minYValue.floorToDouble(),
                          maximum: maxYValue.ceilToDouble(),
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
                            yValueMapper: (ChartData data, _) =>
                                data.firstValue,
                            color: Colors.green,
                            splineType: SplineType.natural,
                          ),
                          SplineSeries<ChartData, DateTime>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.date,
                            yValueMapper: (ChartData data, _) =>
                                data.secondValue,
                            color: Colors.blue,
                            splineType: SplineType.natural,
                          ),
                          SplineSeries<ChartData, DateTime>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.date,
                            yValueMapper: (ChartData data, _) =>
                                data.thirdValue,
                            color: Colors.red,
                            splineType: SplineType.natural,
                          ),
                        ],
                        trackballBehavior: TrackballBehavior(
                          enable: true,
                          activationMode: ActivationMode.longPress,
                          tooltipSettings: const InteractiveTooltip(
                            format: 'point.x : point.y',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child:
                          Text('Min Value: $minYValue, Max Value: $maxYValue'),
                    ),
                    const SizedBox(
                      height: 500,
                      child: Text('sizedbox one'),
                    ),
                    const SizedBox(
                      height: 500,
                      child: Text('sizedbox two'),
                    ),
                  ],
                ),
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
