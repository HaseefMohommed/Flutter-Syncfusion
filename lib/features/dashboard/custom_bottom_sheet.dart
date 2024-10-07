import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_syncfusion/features/dashboard/custom_bottom_sheet_clipper.dart';
import 'package:flutter_syncfusion/features/dashboard/dashboard_screen.dart';
import 'package:flutter_syncfusion/main.dart';

import '../chart/pages/chart_page.dart';

class CustomBottomSheet extends StatefulWidget {
  final DraggableScrollableController scrollController =
      DraggableScrollableController();

  CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  static const double minimumSize = 0.18;
  static const double maximumSize = 0.50;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleSheetExpansion);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_handleSheetExpansion);
    super.dispose();
  }

  void _handleSheetExpansion() {
    final double currentSize = widget.scrollController.size;

    debugPrint('currentSize: $currentSize');

    if (currentSize >= (maximumSize - maximumSize * 0.25) && !isExpanded) {
      setState(() {
        isExpanded = true;
      });
    } else if (currentSize <= (minimumSize + minimumSize * 0.25) &&
        isExpanded) {
      setState(() {
        isExpanded = false;
      });
    }
  }

  final Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: key,
      maxChildSize: maximumSize,
      controller: widget.scrollController,
      initialChildSize: minimumSize,
      minChildSize: minimumSize,
      snapSizes: const [minimumSize, maximumSize],
      snapAnimationDuration: const Duration(milliseconds: 100),
      snap: true,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipPath(
          clipper: CustomBottomSheetClipper(),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: bottomSheetColor,
                  border: Border(
                    top: BorderSide(
                      color: bottomSheetColor,
                      width: 1.0,
                    ),
                    left: BorderSide(
                      color: bottomSheetColor,
                      width: 1.0,
                    ),
                    right: BorderSide(
                      color: bottomSheetColor,
                      width: 1.0,
                    ),
                    bottom: BorderSide.none,
                  ),
                ),
                child: Stack(
                  children: [
                    ListView(
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      children: [
                        const SizedBox(height: 35),
                        GridView.count(
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
                                        chartSeries:
                                            DashboardScreen.chartSeries,
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
                                iconPath =
                                    'assets/svg/bottom_sheet_menu_item_icon.svg';
                                label = 'Menu Item';
                            }
                            return GestureDetector(
                              onTap: () async {
                                if (isExpanded) {
                                  await widget.scrollController.animateTo(
                                    minimumSize,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeInOut,
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
                                    label,
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
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      left: MediaQuery.of(context).size.width / 2 - 25,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: AnimatedRotation(
                          turns: !isExpanded ? 0.0 : 0.5,
                          duration: const Duration(milliseconds: 120),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: bottomSheetColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_up_rounded,
                              size: 50,
                              color: iconColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
