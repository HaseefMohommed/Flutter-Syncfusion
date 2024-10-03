import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/main.dart';

class ChartPageOptionWidget extends StatefulWidget {
  const ChartPageOptionWidget({
    super.key,
  });

  @override
  State<ChartPageOptionWidget> createState() => _ChartPageOptionWidgetState();
}

class _ChartPageOptionWidgetState extends State<ChartPageOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Wrap(
          // direction: isPortrait ? Axis.horizontal : Axis.vertical,
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 100,
          runSpacing: 12,
          children: [
            OptionWidget(
              title: '',
              icon: Icons.arrow_forward_ios_rounded,
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            const OptionWidget(
              title: 'Prop 1',
              icon: Icons.home,
            ),
            const OptionWidget(
              title: 'Prop 2',
              icon: Icons.eco,
              color: Colors.teal,
            ),
            const OptionWidget(
              title: '4 Zones',
              icon: Icons.dashboard,
            ),
            const OptionWidget(
              title: 'Sensor 2',
              icon: Icons.show_chart,
            ),
            const OptionWidget(
              title: 'Sensor 3',
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
  final Color backgroundColor;
  final Function()? onTap;

  const OptionWidget({
    super.key,
    required this.title,
    this.color = buttonBorderColor,
    required this.icon,
    this.showingTimeCard = false,
    this.backgroundColor = primaryColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 130),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: backgroundColor,
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
            SizedBox(
              width: 80,
              child: Text(
                title,
                style: TextStyle(
                    color: color,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis),
              ),
            )
            // Flexible(
            //   child: showingTimeCard
            //       ? const Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             TimeCardWidget(
            //               title: '24h',
            //               isSelected: true,
            //             ),
            //             TimeCardWidget(
            //               title: '3d',
            //             ),
            //             TimeCardWidget(
            //               title: '1w',
            //             ),
            //           ],
            //         )
            //       : Text(
            //           title,
            //           style: TextStyle(
            //             color: color,
            //             fontSize: 12,
            //           ),
            //         ),
            // ),
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
