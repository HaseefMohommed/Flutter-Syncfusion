import 'package:flutter/material.dart';

import '../../../main.dart';
import '../room_dashboard_page.dart';
import '../models/room_dashboard_chart_series_data_model.dart';
import 'chart_page_chart_widget.dart';
import 'chart_page_option_widget.dart';
import 'chart_page_selected_points_row.dart';

class LandscapeLayout extends StatefulWidget {
  const LandscapeLayout({
    super.key,
    required this.chartSeries,
    required this.minYValue,
    required this.maxYValue,
  });

  final List<List<RoomDashboardChartSeriesDataModel>> chartSeries;
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
