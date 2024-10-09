import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/features/dashboard/widgets/dashboard_custom_bottom_sheet_clipper.dart';
import 'package:flutter_syncfusion/features/dashboard/widgets/dashboard_custom_bottom_sheet_icon_grid.dart';

import '../../../theme/theme_colors.dart';

class DashboardCustomBottomSheet extends StatefulWidget {
  final DraggableScrollableController _scrollController =
      DraggableScrollableController();

  final List<Widget> children;

  DashboardCustomBottomSheet({
    super.key,
    required this.children,
  });

  @override
  State<DashboardCustomBottomSheet> createState() =>
      _DashboardCustomBottomSheetState();
}

class _DashboardCustomBottomSheetState extends State<DashboardCustomBottomSheet>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  static const double minimumSize = 0.18;
  static const double maximumSize = 0.48;

  @override
  void initState() {
    super.initState();
    widget._scrollController.addListener(_handleSheetExpansion);
  }

  @override
  void dispose() {
    widget._scrollController.removeListener(_handleSheetExpansion);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              ...widget.children,
              const SizedBox(height: 150),
            ],
          ),
        ),
        isExpanded
            ? GestureDetector(
                onTap: () {
                  debugPrint('tapped');
                  _animateSheetExpansion(
                    null,
                    null,
                    isExpanded,
                    widget._scrollController,
                    () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  );
                },
                child: AnimatedContainer(
                  // animation duration for darkening the background
                  duration: const Duration(milliseconds: 250),
                  color: isExpanded
                      ? Colors.black.withOpacity(0.5)
                      : Colors.black.withOpacity(0.0),
                ),
              )
            : Container(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: _buildDraggableBottomSheet()),
          ],
        ),
      ],
    );
  }

  void _animateSheetExpansion(
    int? tappedIndex,
    int? index,
    bool isExpanded,
    DraggableScrollableController scrollController,
    Function onTap,
  ) async {
    // animate the tapped icon only if it is clicked
    if (tappedIndex != null && index != null) {
      setState(() {
        tappedIndex = index;
      });
      await Future.delayed(const Duration(milliseconds: 150), () {
        setState(() {
          tappedIndex = -1;
        });
      });
    }

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

    await Future.delayed(
      const Duration(milliseconds: 90),
    );

    if (tappedIndex != null && index != null) {
      onTap();
    }
  }

  Widget _buildDraggableBottomSheet() {
    return DraggableScrollableSheet(
      maxChildSize: maximumSize,
      controller: widget._scrollController,
      initialChildSize: minimumSize,
      minChildSize: minimumSize,
      snapSizes: const [minimumSize, maximumSize],
      snapAnimationDuration: const Duration(milliseconds: 100),
      snap: true,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipPath(
          clipper: DashboardCustomBottomSheetClipper(),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ThemeColors.bottomSheetColor,
                  border: Border(
                    top: BorderSide(
                      color: ThemeColors.bottomSheetColor,
                      width: 1.0,
                    ),
                    left: BorderSide(
                      color: ThemeColors.bottomSheetColor,
                      width: 1.0,
                    ),
                    right: BorderSide(
                      color: ThemeColors.bottomSheetColor,
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
                        const SizedBox(height: 40),
                        DashboardCustomBottomSheetIconGrid(
                          isExpanded: isExpanded,
                          scrollController: widget._scrollController,
                          minimumSize: minimumSize,
                        ),
                      ],
                    ),
                    _responsiveExpandIndicator(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _responsiveExpandIndicator() {
    return Positioned(
      top: 8,
      left: MediaQuery.of(context).size.width / 2 - 20,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedRotation(
          turns: !isExpanded ? 0.0 : 0.5,
          duration: const Duration(milliseconds: 150),
          child: Container(
            decoration: BoxDecoration(
              color: ThemeColors.bottomSheetColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.keyboard_arrow_up_rounded,
              size: 40,
              color: Color(0xFF89C9FF),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSheetExpansion() {
    final double currentSize = widget._scrollController.size;

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
}
