import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/room_dashboard_cubit.dart';

class ChartPageSelectedPointWidget extends StatelessWidget {
  const ChartPageSelectedPointWidget({
    super.key,
    this.isPortrait = true,
    required this.backgroundColor,
    required this.baseColor,
    required this.index,
  });
  final bool isPortrait;
  final Color backgroundColor;
  final Color baseColor;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomDashboardCubit, RoomDashboardState>(
      bloc: context.read<RoomDashboardCubit>()..loadInitialSelectedPointData(),
      builder: (context, state) {
        if (state is Initial) {
          return const SizedBox.shrink();
        } else if (state is Loading) {
          return Container(
            color: Colors.white.withOpacity(0.1),
            padding: const EdgeInsets.all(8),
            child: const Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        } else if (state is Loaded) {
          final average = state.averages?[index];
          return Container(
            width: isPortrait ? 100 : 150,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: baseColor,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bolt, color: baseColor),
                Text(
                  average?.toStringAsFixed(2) ?? '0.0',
                  style: TextStyle(
                    color: baseColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'dS/m',
                  style: TextStyle(
                    color: baseColor,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          );
        } else if (state is Error) {
          return Container(
            color: Colors.red.withOpacity(0.1),
            padding: const EdgeInsets.all(8),
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
