import 'package:posts_app/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/view/screens/posts_screen.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController!);

    _animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to the next screen after the animation completes
        Navigator.pushReplacementNamed(
          context, PostsScreen.routeName,
        );
      }
    });

    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation!,
      child: SizedBox(
        width: 90.w,
        height: 30.h,
        child: Center(
          child: Image.asset(AssetsManager.splash)
        ),
      ),
    );
  }
}
