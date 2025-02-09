import 'package:flutter/material.dart';
import 'package:portfolio/app/app.bottomsheets.dart';
import 'package:portfolio/app/app.dialogs.dart';
import 'package:portfolio/app/app.locator.dart';
import 'package:portfolio/app/app.router.dart';
import 'package:portfolio/ui/claude/static_page.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const PortfolioApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontFamily: 'Ubuntu'),
          displayMedium: TextStyle(fontFamily: 'Ubuntu'),
          displaySmall: TextStyle(fontFamily: 'Ubuntu'),
          headlineLarge: TextStyle(fontFamily: 'TitleFont'),
          headlineMedium: TextStyle(fontFamily: 'TitleFont'),
          headlineSmall: TextStyle(fontFamily: 'TitleFont'),
          titleLarge: TextStyle(fontFamily: 'TitleFont'),
          titleMedium: TextStyle(fontFamily: 'TitleFont'),
          titleSmall: TextStyle(fontFamily: 'TitleFont'),
          bodyLarge: TextStyle(fontFamily: 'Ubuntu'),
          bodyMedium: TextStyle(fontFamily: 'Ubuntu'),
          bodySmall: TextStyle(fontFamily: 'Ubuntu'),
        ),
    ),
    );
  }
}
