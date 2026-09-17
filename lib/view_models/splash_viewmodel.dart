import 'package:get/get.dart';
import 'package:goals/view/home_dashboard_view.dart';

class SplashViewModel extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // انتظار ثانيتين
    await Future.delayed(const Duration(seconds: 2));

    // الانتقال للشاشة الرئيسية واستبدال الـ Splash
    Get.off(
      () => HomeDashboardView(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 2000),
    );
  }
}
