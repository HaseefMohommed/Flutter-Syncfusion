import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatelessWidget {
  final List<ChartSeries> chartSeries;

  const ChartPage({
    super.key,
    required this.chartSeries,
  });

  (double, double) getMinMaxValues() {
    if (chartSeries.isEmpty) {
      return (0, 0);
    }

    double minValue = double.infinity;
    double maxValue = double.negativeInfinity;

    for (var series in chartSeries) {
      for (var data in series.data) {
        minValue = data.value < minValue ? data.value : minValue;
        maxValue = data.value > maxValue ? data.value : maxValue;
      }
    }

    double buffer = (maxValue - minValue) * 0.1;
    buffer = buffer < 1 ? 1 : buffer;

    double roundedMin = (minValue - buffer).round().toDouble();
    double roundedMax = (maxValue + buffer).round().toDouble();

    return (roundedMin, roundedMax);
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: chartHeight,
                        width: chartWidth,
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          title: const ChartTitle(
                            text: 'Flutter Chart',
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          zoomPanBehavior: ZoomPanBehavior(
                            enablePinching: true,
                            enableDoubleTapZooming: true,
                            enablePanning: true,
                            zoomMode: ZoomMode.x,
                          ),
                          primaryXAxis: DateTimeAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            axisLine: const AxisLine(width: 0),
                            labelStyle: const TextStyle(color: Colors.white),
                            dateFormat: DateFormat.MMMd(),
                            intervalType: DateTimeIntervalType.auto,
                            majorTickLines: const MajorTickLines(
                              width: 0,
                            ),
                          ),
                          primaryYAxis: NumericAxis(
                            minimum: minYValue,
                            maximum: maxYValue,
                            labelStyle: const TextStyle(
                              color: Color(0xFF005ca7),
                            ),
                            majorGridLines: const MajorGridLines(width: 0),
                            axisLine: const AxisLine(
                              width: 1,
                              color: Color(0xFF005ca7),
                            ),
                            majorTickLines:
                                const MajorTickLines(color: Color(0xFF005ca7)),
                          ),
                          series: [
                            ...chartSeries.map((series) =>
                                SplineSeries<ChartDataPoint, DateTime>(
                                  dataSource: series.data,
                                  xValueMapper: (ChartDataPoint data, _) =>
                                      data.date,
                                  yValueMapper: (ChartDataPoint data, _) =>
                                      data.value,
                                  name: series.name,
                                  color: series.color,
                                  splineType: SplineType.monotonic,
                                )),
                          ],
                          legend: Legend(
                            isVisible: true,
                            legendItemBuilder:
                                (legendText, series, point, seriesIndex) {
                              return const CircleAvatar();
                            },
                          ),
                          trackballBehavior: TrackballBehavior(
                            enable: true,
                            activationMode: ActivationMode.longPress,
                            tooltipSettings: const InteractiveTooltip(
                              format: 'point.x : point.y',
                              color: Colors.white,
                              textStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                            'Max vlue: $maxYValue - Min Value :$minYValue'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChartSeries {
  final String name;
  final List<ChartDataPoint> data;
  final Color color;

  ChartSeries({
    required this.name,
    required this.data,
    required this.color,
  });
}

class ChartDataPoint {
  final DateTime date;
  final double value;

  ChartDataPoint(this.date, this.value);
}
