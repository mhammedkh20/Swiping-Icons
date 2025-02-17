import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiping_icons/app_config.dart';
import 'package:swiping_icons/future/home/presentation/pages/swiping_icons_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppConfig.blocs,
      child: MaterialApp(
        title: 'Swiping Icons',
        debugShowCheckedModeBanner: false,
        theme: AppConfig.themeData(),
        home: const SwipingIconsScreen(),
      ),
    );
  }
}
