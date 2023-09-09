
import 'package:posts_app/view/screens/posts_screen.dart';
import 'package:flutter/material.dart';

import '../../view/screens/post_screen.dart';
import '../../view/screens/splash_screen.dart';

class AppConfig {
  static const String appName = 'Posts';

  static const fallbackLocale = Locale('en');
  static final supportedLocales = [const Locale('en'), const Locale('ar')];

  static Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.routeName: (_) => const SplashScreen(),
    PostsScreen.routeName:(_) => const PostsScreen(),
    PostScreen.routeName:(_) => const PostScreen(),
  };
}
