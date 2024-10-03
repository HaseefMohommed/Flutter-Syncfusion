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
          return Column(
            children: [
              Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: buttonBackgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: buttonBorderColor,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.bolt, color: textColor),
                      Text(
                        state.selectedPointData != null
                            ? state.selectedPointData!.value.toStringAsFixed(2)
                            : '0.0',
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'dS/m',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'ECpw',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
