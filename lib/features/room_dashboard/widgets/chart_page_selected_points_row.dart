import 'package:flutter/material.dart';

import '../room_dashboard_page.dart';
import '../models/room_dashboard_chart_series_data_model.dart';
import 'chart_page_selected_point_widget.dart';

class SelectedPointsRow extends StatelessWidget {
  final List<List<RoomDashboardChartSeriesDataModel>> chartSeries;
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
