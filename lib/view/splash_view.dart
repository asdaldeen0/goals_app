import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';
import 'package:goals/view_models/splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _opacity = 0.0;
  double _scale = 0.95;

  @override
  void initState() {
    super.initState();
    Get.put(SplashViewModel());

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
          _scale = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.inkDark,
      body: Center(
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),

                Text(
                  'أَهْـدَافِـي',
                  style: AppTypography.displayMedium.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                    color: AppColors.white,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  width: 32,
                  height: 1.5,
                  color: AppColors.brass.withValues(alpha: 0.5),
                ),

                const SizedBox(height: 12),

                Text(
                  'سِجِلُّ الإِنْجَازَاتِ الشَّخْصِيَّة',
                  style: TextStyle(
                    fontFamily: AppTypography.displayMedium.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                    color: AppColors.brassLight.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
