import 'package:flutter/material.dart';

import 'room_dashboard_chart_data_point_model.dart';

class RoomDashboardChartSeriesDataModel {
  final String name;
  final List<RoomDashboardChartDataPointModel> data;
  final Color color;

  RoomDashboardChartSeriesDataModel({
    required this.name,
    required this.data,
    required this.color,
  });
}
