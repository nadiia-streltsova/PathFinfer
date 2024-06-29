import 'package:flutter/material.dart';
import 'package:pathfinder/navigation/main_navigation.dart';

class App extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(backgroundColor: Colors.lightBlue, foregroundColor: Colors.white),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.lightBlue),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.lightBlue,
              minimumSize: const Size(double.infinity, 50),
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
        ),
      ),
      initialRoute: MainNavigationRouteNames.homeScreen,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
