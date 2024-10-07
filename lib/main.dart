import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_syncfusion/features/chart/cubit/chart_cubit.dart';

import 'features/dashboard/dashboard_screen.dart';

const Color primaryColor = Color(0xFF051638);
const Color buttonBorderColor = Color(0xFF338EDC);
const Color iconColor = Color.fromARGB(255, 116, 190, 255);
const Color textColor = Color(0xFFFFFFFF);
// const Color textColor = Color(0xFF71ABE1);
final Color buttonBackgroundColor = const Color(0xFF338EDC).withOpacity(0.16);
const Color bottomSheetColor = Color.fromARGB(255, 16, 35, 77);

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
      create: (context) => ChartCubit(),
      child: SafeArea(
        bottom: false,
        child: MaterialApp(
          title: 'Aroya Room Dashboard (Demo)',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // scaffoldBackgroundColor: const Color(0xFF0E2039),
            scaffoldBackgroundColor: primaryColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
          home: const DashboardScreen(),
        ),
      ),
    );
  }
}
