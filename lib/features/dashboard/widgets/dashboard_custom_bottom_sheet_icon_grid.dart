import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/theme_colors.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      children: List.generate(10, (index) {
        Function onTap = () {};

        final String iconPath;
        final String label;
        IconData? icon;
        switch (index) {
          case 0:
            iconPath = 'assets/svg/bottom_sheet_icon1.svg';
            label = 'Facility Dashboard';
            icon = Icons.dashboard;
            break;

          case 1:
            iconPath = 'assets/svg/bottom_sheet_icon2.svg';
            icon = Icons.show_chart;
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
            icon = Icons.event_available;
            label = 'Journal';
            break;

          case 3:
            iconPath = 'assets/svg/bottom_sheet_icon4.svg';
            label = 'IPM Events';
            break;

          case 4:
            iconPath = 'assets/svg/bottom_sheet_icon4.svg';
            icon = Icons.alarm;
            label = 'Notifications';
            break;

          case 5:
            iconPath = 'assets/svg/devices_icon.svg';
            label = 'Devices';
            break;

          case 6:
            iconPath = 'assets/svg/bottom_sheet_icon4.svg';
            icon = Icons.bluetooth;
            label = 'SOLUS';
            break;

          case 7:
            iconPath = 'assets/svg/bottom_sheet_icon4.svg';
            icon = Icons.help_outline;
            label = 'Help & Feedback';
            break;

          case 8:
            iconPath = 'assets/svg/bottom_sheet_icon4.svg';
            icon = Icons.info_outline;
            label = 'About';
            break;

          case 9:
            iconPath = 'assets/svg/bottom_sheet_icon4.svg';
            icon = Icons.power_settings_new;
            label = 'Logout';
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
                  icon != null
                      ? Icon(
                          icon,
                          color: ThemeColors.iconColor,
                          size: 30,
                        )
                      : SvgPicture.asset(
                          iconPath,
                          width: 30,
                          height: 30,
                          colorFilter: ColorFilter.mode(
                            ThemeColors.iconColor,
                            BlendMode.srcIn,
                          ),
                        ),
                  const SizedBox(height: 5),
                  Text(
                    label,
                    style: TextStyle(
                      color: ThemeColors.textColor,
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
