import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';
import 'widgets/dashboard_custom_bottom_sheet.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aroya Sample'.toUpperCase(),
          style: TextStyle(
            color: ThemeColors.iconColor,
            fontWeight: FontWeight.w300,
            fontSize: 16,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: DashboardCustomBottomSheet(
        children: [
          _buildSampleBackground(),
        ],
      ),
    );
  }

  Widget _buildSampleBackground() {
    return Image.asset(
      'assets/png/dashboard_sample_screenshot.png',
      fit: BoxFit.fitWidth,
    );
  }
}
