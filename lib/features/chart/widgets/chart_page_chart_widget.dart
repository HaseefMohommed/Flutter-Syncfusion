import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syncfusion/features/chart/cubit/chart_cubit.dart';

import 'package:flutter_syncfusion/features/chart/chart_page.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
          // interactiveTooltip: InteractiveTooltip(
          //   enable: true,
          //   color: Colors.transparent,
          //   textStyle: TextStyle(
          //     color: Colors.white.withOpacity(
          //       0.4,
          //     ),
          //   ),
          // ),
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
        // crosshairBehavior: CrosshairBehavior(
        //   enable: true,
        //   lineWidth: 2,
        //   lineColor: Colors.white,
        //   activationMode: ActivationMode.longPress,
        //   lineType: CrosshairLineType.vertical,
        // ),
        trackballBehavior: TrackballBehavior(
          enable: true,
          lineColor: Colors.white,
          lineWidth: 2,
          lineType: TrackballLineType.vertical,
          activationMode: ActivationMode.longPress,
          // markerSettings: const TrackballMarkerSettings(
          //   color: Colors.white,
          //   markerVisibility: TrackballVisibilityMode.visible,
          //   width: 10,
          //   height: 10,
          // ),
          tooltipSettings: const InteractiveTooltip(
            enable: true,
            arrowLength: 0,
            arrowWidth: 0,
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
          ),
          // shouldAlwaysShow: true,
          tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
          tooltipAlignment: ChartAlignment.far,
          builder: (context, trackballDetails) {
            if (trackballDetails.point != null) {
              final pointIndex = trackballDetails.pointIndex ?? 0;
              final xValue = trackballDetails.point!.x;
              final String formattedDate = (xValue is DateTime)
                  ? DateFormat('M/d h:mm a').format(xValue)
                  : xValue.toString();

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

              return Container(
              
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  formattedDate,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
