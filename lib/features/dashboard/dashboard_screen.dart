import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/main.dart';

import 'widgets/dashboard_custom_bottom_sheet.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aroya Sample'.toUpperCase(),
          style: const TextStyle(
            color: iconColor,
            fontWeight: FontWeight.w300,
            fontSize: 16,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildSampleBackground(),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: CustomBottomSheet()),
            ],
          ),
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
