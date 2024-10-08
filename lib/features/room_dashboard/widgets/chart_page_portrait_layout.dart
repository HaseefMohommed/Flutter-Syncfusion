import 'package:flutter/material.dart';

import '../models/room_dashboard_chart_series_data_model.dart';
import 'chart_page_chart_widget.dart';
import 'chart_page_option_widget.dart';
import 'chart_page_selected_points_row.dart';

class PortraitLayout extends StatelessWidget {
  final List<List<RoomDashboardChartSeriesDataModel>> chartSeries;
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
