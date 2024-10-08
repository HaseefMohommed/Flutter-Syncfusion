import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/main.dart';

class ChartPageOptionWidget extends StatelessWidget {
  final bool isPortrait;
  final bool showTitles;
  final VoidCallback? onToggleTitles;

  const ChartPageOptionWidget({
    super.key,
    required this.showTitles,
    this.onToggleTitles,
    required this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 100,
      runSpacing: 12,
      children: [
        if (!isPortrait) ...[
          AnimatedRotation(
            turns: showTitles ? 0.0 : 0.5,
            duration: const Duration(milliseconds: 200),
            child: OptionWidget(
              title: '',
              showTitle: false,
              icon: Icons.arrow_forward_ios_rounded,
              onTap: onToggleTitles,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
        OptionWidget(
          title: 'Prop 1',
          icon: Icons.home,
          showTitle: isPortrait ? true : showTitles,
        ),
        OptionWidget(
          title: 'Prop 2',
          icon: Icons.eco,
          color: Colors.teal,
          showTitle: isPortrait ? true : showTitles,
        ),
        OptionWidget(
          title: '4 Zones',
          icon: Icons.dashboard,
          showTitle: isPortrait ? true : showTitles,
        ),
        OptionWidget(
          title: 'Sensor 2',
          icon: Icons.show_chart,
          showTitle: isPortrait ? true : showTitles,
        ),
        OptionWidget(
          title: 'Sensor 3',
          icon: Icons.settings,
          showingTimeCard: true,
          showTitle: isPortrait ? true : showTitles,
        ),
      ],
    );
  }
}

class OptionWidget extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final bool showingTimeCard;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final bool showTitle;

  const OptionWidget({
    super.key,
    required this.title,
    this.color = buttonBorderColor,
    required this.icon,
    this.showingTimeCard = false,
    this.backgroundColor = primaryColor,
    this.onTap,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(maxWidth: showTitle ? 130 : 40),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
                border: Border.all(color: color),
              ),
              child: Icon(icon, color: color),
            ),
            if (showTitle) ...[
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class TimeCardWidget extends StatelessWidget {
  final String title;
  final bool isSelected;

  const TimeCardWidget({
    super.key,
    this.isSelected = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? textColor : Colors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }
}
