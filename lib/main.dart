import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syncfusion/features/room_dashboard/cubit/room_dashboard_cubit.dart';

import 'features/dashboard/dashboard_screen.dart';
import 'theme/theme_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomDashboardCubit(),
      child: SafeArea(
        bottom: false,
        child: MaterialApp(
          title: 'Aroya Room Dashboard (Demo)',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // scaffoldBackgroundColor: const Color(0xFF0E2039),
            scaffoldBackgroundColor: ThemeColors.primaryColor,
            appBarTheme: AppBarTheme(
              backgroundColor: ThemeColors.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
          home: const DashboardScreen(),
        ),
      ),
    );
  }
}
