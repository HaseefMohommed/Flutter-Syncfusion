import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/main.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  final List<List<ChartSeries>> chartSeries;

  const ChartPage({
    super.key,
    required this.chartSeries,
  });

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  ChartDataPoint? selectedPoint;
  @override
  Widget build(BuildContext context) {
    final (minYValue, maxYValue) = _getMinMaxValues(widget.chartSeries);

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
                            for (List<ChartSeries> series in widget.chartSeries)
                              for (ChartSeries chartSeries in series)
                                LineSeries<ChartDataPoint, DateTime>(
                                  dataSource: chartSeries.data,
                                  xValueMapper: (data, _) => data.date,
                                  yValueMapper: (data, _) => data.value,
                                  name: chartSeries.name,
                                  color: chartSeries.color,
                                  dataLabelSettings: const DataLabelSettings(
                                    isVisible: false,
                                  ),
                                )
                          ],
                          enableAxisAnimation: true,
                          legend: Legend(
                            orientation: LegendItemOrientation.horizontal,
                            overflowMode: LegendItemOverflowMode.wrap,
                            itemPadding: 15.0,
                            isVisible: true,
                            legendItemBuilder:
                                (legendText, series, point, seriesIndex) {
                              int setIndex = 0;
                              int seriesInSetIndex = seriesIndex;

                              for (var chartSet in widget.chartSeries) {
                                if (seriesInSetIndex < chartSet.length) {
                                  break;
                                }
                                seriesInSetIndex -= chartSet.length;
                                setIndex++;
                              }

                              Color seriesColor = widget
                                  .chartSeries[setIndex][seriesInSetIndex]
                                  .color;

                              return SizedBox(
                                width: 50,
                                height: 50,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: seriesColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          point.y?.toStringAsFixed(2) ?? '0',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          trackballBehavior: TrackballBehavior(
                              enable: true,
                              activationMode: ActivationMode.longPress,
                              tooltipSettings: const InteractiveTooltip(
                                format: 'point.x : point.y',
                                color: primaryColor,
                                textStyle: TextStyle(color: Colors.white),
                              ),
                              shouldAlwaysShow: true,
                              builder: (context, trackballDetails) {
                                if (trackballDetails.point != null) {
                                  final dataPoint = trackballDetails.point!;
                                  selectedPoint = ChartDataPoint(
                                      dataPoint.x, dataPoint.y!.toDouble());
                                  // setState(() {
                                  // });
                                }

                                return Container();
                              }),
                        ),
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.1),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          selectedPoint != null
                              ? 'Selected Point: ${selectedPoint!.date} - ${selectedPoint!.value}'
                              : 'No point selected',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.1),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Max vlue: $maxYValue - Min Value :$minYValue',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
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

  (double, double) _getMinMaxValues(List<List<ChartSeries>> allChartSeries) {
    double minValue = double.infinity;
    double maxValue = double.negativeInfinity;

    // Iterate over all series in all sets
    for (var chartSet in allChartSeries) {
      for (var series in chartSet) {
        for (var data in series.data) {
          minValue = data.value < minValue ? data.value : minValue;
          maxValue = data.value > maxValue ? data.value : maxValue;
        }
      }
    }

    double buffer = (maxValue - minValue) * 0.1;
    buffer = buffer < 1 ? 1 : buffer;

    double roundedMin = (minValue - buffer).round().toDouble();
    double roundedMax = (maxValue + buffer).round().toDouble();

    return (roundedMin, roundedMax);
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
