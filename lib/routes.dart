import 'package:catalogo/domain/entities/ofensor.dart';
import 'package:flutter/material.dart';
import 'package:catalogo/core/fade_page_route.dart';
import 'package:catalogo/ui/screens/home/home.dart';
import 'package:catalogo/ui/screens/catalogo/catalogo.dart';
import 'package:catalogo/ui/screens/ofensor_info/ofensor_info.dart';
import 'package:catalogo/ui/screens/splash/splash.dart';
import 'package:catalogo/ui/screens/types/type_screen.dart';

enum Routes { splash, home, catalogo, OfensorInfo, typeEffects }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String catalogo = '/home/catalogo';
  static const String OfensorInfo = '/home/Ofensor';
  static const String typeEffectsScreen = '/home/type';
  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.catalogo: _Paths.catalogo,
    Routes.OfensorInfo: _Paths.OfensorInfo,
    Routes.typeEffects: _Paths.typeEffectsScreen,
  };

  static String of(Routes route) => _pathMap[route];
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.splash:
        return FadeRoute(page: SplashScreen());

      case _Paths.catalogo:
        return FadeRoute(page: CatalogoScreen());

      case _Paths.OfensorInfo:
        return FadeRoute(page: OfensorInfo(settings.arguments));

      case _Paths.typeEffectsScreen:
        return FadeRoute(page: TypeEffectScreen());

      case _Paths.home:
      default:
        return FadeRoute(page: HomeScreen());
    }
  }

  static Future push<T>(Routes route, [T arguments]) =>
      state.pushNamed(_Paths.of(route), arguments: arguments);

  static Future replaceWith<T>(Routes route, [T arguments]) =>
      state.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state.pop();

  static NavigatorState get state => navigatorKey.currentState;
}
