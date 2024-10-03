import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/main.dart';

class ChartPageOptionWidget extends StatelessWidget {
  const ChartPageOptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return Wrap(
          direction: isPortrait ? Axis.horizontal : Axis.vertical,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: const [
            OptionWidget(
              title: 'Prop 1',
              icon: Icons.home,
            ),
            OptionWidget(
              title: 'Prop 2',
              icon: Icons.eco,
              color: Colors.teal,
            ),
            OptionWidget(
              title: '4 Zones',
              icon: Icons.dashboard,
            ),
            OptionWidget(
              title: '2 Sensor Value',
              icon: Icons.show_chart,
            ),
            OptionWidget(
              title: '2 Sensor Value',
              icon: Icons.settings,
              showingTimeCard: true,
            ),
          ],
        );
      },
    );
  }
}

class OptionWidget extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final bool showingTimeCard;

  const OptionWidget({
    super.key,
    required this.title,
    this.color = buttonBorderColor,
    required this.icon,
    this.showingTimeCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: color,
              ),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: showingTimeCard
                ? const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TimeCardWidget(
                        title: '24h',
                        isSelected: true,
                      ),
                      TimeCardWidget(
                        title: '3d',
                      ),
                      TimeCardWidget(
                        title: '1w',
                      ),
                    ],
                  )
                : Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                    ),
                  ),
          ),
        ],
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
