import 'package:flutter/material.dart';
import 'package:nako2/providers/berita_panel_provider.dart';
import 'package:nako2/providers/dashboard_providers.dart';
import 'package:nako2/views/login_view.dart';
import 'package:provider/provider.dart';

// void < == ?
main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => DashboardProvider()),
      ChangeNotifierProvider(create: (c) => BeritaPanelProvider())
    ],
    builder: (context, Widget) {
      return MaterialApp(
        theme:
            ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.orange)),
        home: LoginView(),
      );
    },
  ));
}
