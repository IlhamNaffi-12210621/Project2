import 'package:flutter/material.dart';
import 'package:nako2/providers/berita_panel_provider.dart';
import 'package:nako2/providers/dashboard_providers.dart';
import 'package:nako2/providers/peta_provider.dart';
import 'package:nako2/views/login_view.dart';
import 'package:provider/provider.dart';

// void < == ?
main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => DashboardProvider()),
      ChangeNotifierProvider(create: (c) => BeritaPanelProvider()),
      ChangeNotifierProvider(create: (c) => PetaProvider())
    ],
    builder: (context, Widget) {
      context.read<PetaProvider>().mulai_bacalokasi();
      return MaterialApp(
        theme:
            ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.orange)),
        home: LoginView(),
      );
    },
  ));
}
