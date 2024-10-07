import 'package:flutter/material.dart';
import 'package:flutter_syncfusion/features/dashboard/widgets/custom_bottom_sheet_clipper.dart';
import 'package:flutter_syncfusion/features/dashboard/widgets/custom_bottom_sheet_icon_grid.dart';
import 'package:flutter_syncfusion/main.dart';

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
  static const double maximumSize = 0.48;

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

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
                        const SizedBox(height: 40),
                        CustomBottomSheetIconGrid(
                          isExpanded: isExpanded,
                          scrollController: widget.scrollController,
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
    );
  }

  void _handleSheetExpansion() {
    final double currentSize = widget.scrollController.size;

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
