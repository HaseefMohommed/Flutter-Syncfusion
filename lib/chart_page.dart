import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/chart_page_chart_widget.dart';
import 'package:flutter_syncfusion/chart_page_selected_point_widget.dart';
import 'package:flutter_syncfusion/main.dart';

import 'chart_page_option_widget.dart';

class ChartPage extends StatefulWidget {
  final List<List<ChartSeriesData>> chartSeries;

  const ChartPage({super.key, required this.chartSeries});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  bool _showTitles = true;

  void _toggleTitles() {
    setState(() {
      _showTitles = !_showTitles;
    });
  }

  @override
  Widget build(BuildContext context) {
    final (minYValue, maxYValue) = _getMinMaxValues(widget.chartSeries);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Room Dashboard'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: OrientationBuilder(
              builder: (context, orientation) {
                if (MediaQuery.of(context).orientation ==
                    Orientation.portrait) {
                  return Column(
                    children: [
                      _buildSelectedPointsRow(true),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ChartPageChartWidget(
                          chartSeries: widget.chartSeries,
                          minYValue: minYValue,
                          maxYValue: maxYValue,
                          chartHeight: double.infinity,
                          chartWidth: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ChartPageOptionWidget(
                          showTitles: _showTitles,
                          onToggleTitles: _toggleTitles,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildSelectedPointsRow(false),
                            ChartPageChartWidget(
                              chartSeries: widget.chartSeries,
                              minYValue: minYValue,
                              maxYValue: maxYValue,
                              chartHeight:
                                  MediaQuery.of(context).size.height * 0.8,
                              chartWidth: MediaQuery.of(context).size.width *
                                  (_showTitles ? 0.70 : 0.80),
                            ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: _showTitles ? 142 : 76,
                        child: SizedBox(
                          height: 290,
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: VerticalDivider(
                                  color: buttonBorderColor,
                                ),
                              ),
                              SizedBox(
                                width: 130,
                                child: ChartPageOptionWidget(
                                  showTitles: _showTitles,
                                  onToggleTitles: _toggleTitles,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }

  Widget _buildSelectedPointsRow(bool isPortrait) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ChartPageSelectedPointWidget(
          isPortrait: isPortrait,
          backgroundColor: widget.chartSeries[0].first.color.withOpacity(0.4),
          baseColor: widget.chartSeries[0].first.color,
          index: 0,
        ),
        ChartPageSelectedPointWidget(
          isPortrait: isPortrait,
          backgroundColor: widget.chartSeries[1].first.color.withOpacity(0.4),
          baseColor: widget.chartSeries[1].first.color,
          index: 1,
        ),
        ChartPageSelectedPointWidget(
          isPortrait: isPortrait,
          backgroundColor: widget.chartSeries[2].first.color.withOpacity(0.4),
          baseColor: widget.chartSeries[2].first.color,
          index: 2,
        ),
      ],
    );
  }

  (double, double) _getMinMaxValues(
      List<List<ChartSeriesData>> allChartSeries) {
    double minValue = double.infinity;
    double maxValue = double.negativeInfinity;

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

class ChartSeriesData {
  final String name;
  final List<ChartDataPoint> data;
  final Color color;

  ChartSeriesData({
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
