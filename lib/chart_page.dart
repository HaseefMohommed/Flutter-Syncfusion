import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/chart_page_chart_widget.dart';
import 'package:flutter_syncfusion/chart_page_selected_point_widget.dart';
import 'package:flutter_syncfusion/main.dart';

import 'chart_page_option_widget.dart';

class ChartPage extends StatelessWidget {
  final List<List<ChartSeriesData>> chartSeries;

  const ChartPage({super.key, required this.chartSeries});

  @override
  Widget build(BuildContext context) {
    final (minYValue, maxYValue) = _getMinMaxValues(chartSeries);

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
                          chartSeries: chartSeries,
                          minYValue: minYValue,
                          maxYValue: maxYValue,
                          chartHeight: double.infinity,
                          chartWidth: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // TODO: @Haseef: If have time, see if you can come up with a better layout to display the chart page options widget in protait mode. If not, let's hide it in portrait mode.
                      const Center(
                        child: ChartPageOptionWidget(),
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
                              chartSeries: chartSeries,
                              minYValue: minYValue,
                              maxYValue: maxYValue,
                              chartHeight:
                                  MediaQuery.of(context).size.height * 0.8,
                              chartWidth:
                                  MediaQuery.of(context).size.width * 0.60,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 290,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: VerticalDivider(
                                color: buttonBorderColor,
                              ),
                            ),
                            SizedBox(
                              width: 130,
                              child: ChartPageOptionWidget(),
                            ),
                          ],
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
        ChartPageSelectedPointWidget(isPortrait: isPortrait),
        ChartPageSelectedPointWidget(isPortrait: isPortrait),
        ChartPageSelectedPointWidget(isPortrait: isPortrait),
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
