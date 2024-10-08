import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/room_dashboard_chart_series_data_model.dart';
import 'widgets/chart_page_landscape_layout.dart';
import 'widgets/chart_page_portrait_layout.dart';

class RoomDashboardPage extends StatefulWidget {
  final List<List<RoomDashboardChartSeriesDataModel>> chartSeries;

  const RoomDashboardPage({super.key, required this.chartSeries});

  @override
  State<RoomDashboardPage> createState() => _RoomDashboardPageState();
}

class _RoomDashboardPageState extends State<RoomDashboardPage> {
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
      List<List<RoomDashboardChartSeriesDataModel>> allChartSeries) {
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
