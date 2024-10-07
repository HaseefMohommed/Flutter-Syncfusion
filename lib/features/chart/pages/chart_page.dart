import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syncfusion/features/chart/widgets/chart_page_chart_widget.dart';
import 'package:flutter_syncfusion/features/chart/widgets/chart_page_selected_point_widget.dart';
import 'package:flutter_syncfusion/main.dart';

import '../widgets/chart_page_option_widget.dart';

class ChartPage extends StatefulWidget {
  final List<List<ChartSeriesData>> chartSeries;

  const ChartPage({super.key, required this.chartSeries});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
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
                  return PortraitLayout(
                    chartSeries: widget.chartSeries,
                    minYValue: minYValue,
                    maxYValue: maxYValue,
                  );
                } else {
                  return LandscapeLayout(
                    chartSeries: widget.chartSeries,
                    minYValue: minYValue,
                    maxYValue: maxYValue,
                  );
                }
              },
            ),
          ),
        ));
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

class LandscapeLayout extends StatefulWidget {
  const LandscapeLayout({
    super.key,
    required this.chartSeries,
    required this.minYValue,
    required this.maxYValue,
  });

  final List<List<ChartSeriesData>> chartSeries;
  final double minYValue;
  final double maxYValue;

  @override
  State<LandscapeLayout> createState() => _LandscapeLayoutState();
}

class _LandscapeLayoutState extends State<LandscapeLayout> {
  bool _showTitles = true;

  void _toggleTitles() {
    setState(() {
      _showTitles = !_showTitles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  SelectedPointsRow(
                    chartSeries: widget.chartSeries,
                    isPortrait: false,
                  ),
                  ChartPageChartWidget(
                    chartSeries: widget.chartSeries,
                    minYValue: widget.minYValue,
                    maxYValue: widget.maxYValue,
                    chartHeight: MediaQuery.of(context).size.height * 0.8,
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
                        isPortrait: false,
                        showTitles: _showTitles,
                        onToggleTitles: _toggleTitles,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 200,
        )
      ],
    );
  }
}

class SelectedPointsRow extends StatelessWidget {
  final List<List<ChartSeriesData>> chartSeries;
  const SelectedPointsRow({
    super.key,
    required this.isPortrait,
    required this.chartSeries,
  });

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ChartPageSelectedPointWidget(
          isPortrait: isPortrait,
          backgroundColor: chartSeries[0].first.color.withOpacity(0.4),
          baseColor: chartSeries[0].first.color,
          index: 0,
        ),
        ChartPageSelectedPointWidget(
          isPortrait: isPortrait,
          backgroundColor: chartSeries[1].first.color.withOpacity(0.4),
          baseColor: chartSeries[1].first.color,
          index: 1,
        ),
        ChartPageSelectedPointWidget(
          isPortrait: isPortrait,
          backgroundColor: chartSeries[2].first.color.withOpacity(0.4),
          baseColor: chartSeries[2].first.color,
          index: 2,
        ),
      ],
    );
  }
}

class PortraitLayout extends StatelessWidget {
  final List<List<ChartSeriesData>> chartSeries;
  const PortraitLayout({
    super.key,
    required this.minYValue,
    required this.maxYValue,
    required this.chartSeries,
  });

  final double minYValue;
  final double maxYValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectedPointsRow(chartSeries: chartSeries, isPortrait: true),
        const SizedBox(height: 5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ChartPageChartWidget(
            chartSeries: chartSeries,
            minYValue: minYValue,
            maxYValue: maxYValue,
            chartHeight: double.infinity,
            chartWidth: double.infinity,
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: ChartPageOptionWidget(
            isPortrait: true,
            showTitles: true,
          ),
        ),
      ],
    );
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
