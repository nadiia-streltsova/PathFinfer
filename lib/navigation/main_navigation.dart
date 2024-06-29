import 'package:flutter/material.dart';
import 'package:pathfinder/services/path_data_service.dart';
import 'package:pathfinder/widgets/home_screen/home_screen_view_model.dart';
import 'package:pathfinder/widgets/home_screen/home_screen_widget.dart';
import 'package:pathfinder/widgets/preview_screen/preview_screen_view_model.dart';
import 'package:pathfinder/widgets/preview_screen/preview_screen_widget.dart';
import 'package:pathfinder/widgets/process_screen/process_screen_view_model.dart';
import 'package:pathfinder/widgets/process_screen/process_screen_widget.dart';
import 'package:pathfinder/widgets/result_list_screen/result_list_screen_view_model.dart';
import 'package:pathfinder/widgets/result_list_screen/result_list_screen_widget.dart';
import 'package:provider/provider.dart';

abstract class MainNavigationRouteNames {
  static const homeScreen = "/";
  static const processScreen = "/process_screen";
  static const resultScreen = "/process_screen/result_screen";
  static const previewScreen = "/process_screen/result_screen/preview_screen";
}

class MainNavigation {
  final PathDataService pathDataService = PathDataService();

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.homeScreen:
        final arguments = settings.arguments;
        final msg = arguments is String ? arguments : "";
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (_) => HomeScreenViewModel(pathDataService, msg),
                  child: const HomeScreenWidget(),
                ));
      case MainNavigationRouteNames.processScreen:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (_) => ProcessScreenViewModel(pathDataService),
                  child: const ProcessScreenWidget(),
                ));
      case MainNavigationRouteNames.resultScreen:
        return MaterialPageRoute(
            builder: (_) => Provider(
                  create: (_) => ResultListScreenViewModel(pathDataService),
                  child: const ResultListScreenWidget(),
                ));
      case MainNavigationRouteNames.previewScreen:
        final arguments = settings.arguments;
        final index = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (_) => Provider(
                  create: (_) => PreviewScreenViewModel(pathDataService, index),
                  child: const PreviewScreenWidget(),
                ));
      default:
        const widget = Text("Navigation Error!");
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}
