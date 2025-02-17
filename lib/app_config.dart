// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:swiping_icons/future/home/presentation/manager/scroll_bloc.dart';

class AppConfig {
  static ThemeData themeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  static List<SingleChildWidget> blocs = [
    BlocProvider(create: (_) => ScrollBloc()),
  ];
}
