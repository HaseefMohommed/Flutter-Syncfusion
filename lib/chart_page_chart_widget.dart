import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syncfusion/chart_page.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'cubit/chart_cubit.dart';

class ChartPageChartWidget extends StatelessWidget {
  const ChartPageChartWidget({
    super.key,
    required this.chartSeries,
    required this.minYValue,
    required this.maxYValue,
    required this.chartHeight,
    required this.chartWidth,
  });

  final List<List<ChartSeriesData>> chartSeries;
  final double minYValue;
  final double maxYValue;
  final double chartHeight;
  final double chartWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: chartHeight,
      width: chartWidth,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enableDoubleTapZooming: true,
          enablePanning: true,
          zoomMode: ZoomMode.x,
        ),
        primaryXAxis: DateTimeAxis(
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(width: 0),
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          dateFormat: DateFormat.MMMd(),
          intervalType: DateTimeIntervalType.auto,
          majorTickLines: const MajorTickLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          minimum: minYValue,
          maximum: maxYValue,
          isVisible: false,
          labelStyle: const TextStyle(color: Color(0xFF005ca7)),
          majorGridLines: const MajorGridLines(width: 0),
          axisLine: const AxisLine(width: 1, color: Color(0xFF005ca7)),
          majorTickLines: const MajorTickLines(color: Color(0xFF005ca7)),
        ),
        series: [
          for (List<ChartSeriesData> series in chartSeries)
            for (ChartSeriesData chartSeries in series)
              LineSeries<ChartDataPoint, DateTime>(
                dataSource: chartSeries.data,
                xValueMapper: (data, _) => data.date,
                yValueMapper: (data, _) => data.value,
                name: chartSeries.name,
                color: chartSeries.color,
                dataLabelSettings: const DataLabelSettings(isVisible: false),
              ),
        ],
        enableAxisAnimation: true,
        trackballBehavior: TrackballBehavior(
          enable: true,
          lineColor: Colors.white,
          lineWidth: 2,
          activationMode: ActivationMode.longPress,
          tooltipSettings: const InteractiveTooltip(
            format: 'point.x : point.y',
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
          ),
          shouldAlwaysShow: true,
          builder: (context, trackballDetails) {
            if (trackballDetails.point != null) {
              final pointIndex = trackballDetails.pointIndex ?? 0;

              List<double> averages = [];

              for (var seriesList in chartSeries) {
                double seriesSum = 0;
                int seriesCount = 0;

                for (var series in seriesList) {
                  if (pointIndex < series.data.length) {
                    seriesSum += series.data[pointIndex].value;
                    seriesCount++;
                  }
                }

                if (seriesCount > 0) {
                  double average = seriesSum / seriesCount;
                  averages.add(average);
                }
              }

              BlocProvider.of<ChartCubit>(context)
                  .updateAveragePointData(averages);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
