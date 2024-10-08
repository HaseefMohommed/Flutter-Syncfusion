import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';
import '../../../utils/helpers/chart_sample_helper.dart';
import '../../room_dashboard/room_dashboard_page.dart';

class DashboardCustomBottomSheetIconGrid extends StatefulWidget {
  const DashboardCustomBottomSheetIconGrid({
    super.key,
    required this.isExpanded,
    required this.scrollController,
    required this.minimumSize,
  });
  final bool isExpanded;
  final DraggableScrollableController scrollController;
  final double minimumSize;

  @override
  State<DashboardCustomBottomSheetIconGrid> createState() =>
      _DashboardCustomBottomSheetIconGridState();
}

class _DashboardCustomBottomSheetIconGridState
    extends State<DashboardCustomBottomSheetIconGrid> {
  int _tappedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 00,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: List.generate(12, (index) {
        Function onTap = () {};
        final String iconPath;
        final String label;
        switch (index) {
          case 0:
            iconPath = 'assets/svg/bottom_sheet_icon1.svg';
            label = 'Facility Dashboard';
            break;

          case 1:
            iconPath = 'assets/svg/bottom_sheet_icon2.svg';
            label = 'Room Dashboard';
            onTap = () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDashboardPage(
                    chartSeries: ChartSampleHelper.chartSeries,
                  ),
                ),
              );
            };
            break;

          case 2:
            iconPath = 'assets/svg/bottom_sheet_icon3.svg';
            label = 'Journal';
            break;

          case 3:
            iconPath = 'assets/svg/bottom_sheet_icon4.svg';
            label = 'IPM Events';
            break;

          default:
            iconPath = 'assets/svg/bottom_sheet_menu_item_icon.svg';
            label = 'Menu Item';
        }
        return GestureDetector(
          onTap: () async {
            setState(() {
              _tappedIndex = index;
            });
            await Future.delayed(const Duration(milliseconds: 150), () {
              setState(() {
                _tappedIndex = -1;
              });
            });
            if (widget.isExpanded) {
              await widget.scrollController.animateTo(
                widget.minimumSize,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
              await Future.delayed(
                const Duration(milliseconds: 180),
              );
            }

            await Future.delayed(
              const Duration(milliseconds: 90),
            );
            onTap();
          },
          child: AnimatedScale(
            scale: _tappedIndex == index ? 0.9 : 1.0,
            duration: const Duration(milliseconds: 50),
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    width: 30,
                    height: 30,
                    colorFilter: const ColorFilter.mode(
                      iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    label != 'Menu Item' ? label : '$label $index',
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
