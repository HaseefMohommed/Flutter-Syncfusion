import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';
import '../../../utils/helpers/chart_sample_helper.dart';
import '../../chart/chart_page.dart';

class CustomBottomSheetIconGrid extends StatelessWidget {
  const CustomBottomSheetIconGrid({
    super.key,
    required this.isExpanded,
    required this.scrollController,
    required this.minimumSize,
  });
  final bool isExpanded;
  final DraggableScrollableController scrollController;
  final double minimumSize;

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
                  builder: (context) => ChartPage(
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
            if (isExpanded) {
              await scrollController.animateTo(
                minimumSize,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
              await Future.delayed(
                const Duration(milliseconds: 180),
              );
            }
            onTap();
          },
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
        );
      }),
    );
  }
}
