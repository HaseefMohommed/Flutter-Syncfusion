import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syncfusion/main.dart';

import 'cubit/chart_cubit.dart';

class ChartPageSelectedPointWidget extends StatelessWidget {
  const ChartPageSelectedPointWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartCubit, ChartState>(
      bloc: context.read<ChartCubit>()..loadInitialSelectedPointData(),
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
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: buttonBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: buttonBorderColor,
              ),
            ),
            child: Text(
              state.selectedPointData != null
                  ? state.selectedPointData!.value.toStringAsFixed(2)
                  : 'No point selected',
              style: const TextStyle(
                color: textColor,
              ),
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
