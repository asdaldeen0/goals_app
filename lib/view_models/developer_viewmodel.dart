import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals/core/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperViewModel extends GetxController {
  final String developerName = 'أسد الدين';
  final String developerRole = 'مطور ومصمم تطبيقات Flutter';
  final String developerBio =
      'شغوف ببناء وتطوير تطبيقات جوال متكاملة تجمع بين الأداء العالي والتصميم العصري وتجربة المستخدم السلسة.';

  final String instagramHandle = '@asdaldeen0';
  final String instagramUrl = 'https://instagram.com';
  final String whatsappNumber = '+967770000000';

  Future<void> openInstagram() async {
    final uri = Uri.parse(instagramUrl);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        _showError('تعذر فتح تطبيق إنستغرام');
      }
    } catch (_) {
      _showError('حدث خطأ أثناء فتح الرابط');
    }
  }

  Future<void> openWhatsApp([String? customMessage]) async {
    final message =
        customMessage ??
        'مرحباً أسد الدين، لدي اقتراح ورأي بخصوص تطبيق أهدافي: ';
    final encodedMessage = Uri.encodeComponent(message);
    final cleanPhone = whatsappNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final uri = Uri.parse('https://wa.me/$cleanPhone?text=$encodedMessage');

    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        _showError('تعذر فتح تطبيق واتساب');
      }
    } catch (_) {
      _showError('حدث خطأ أثناء الاتصال بالواتساب');
    }
  }

  void _showError(String message) {
    Get.snackbar(
      'تنبيه',
      message,
      backgroundColor: AppColors.seal.withValues(alpha: 0.12),
      colorText: AppColors.seal,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
    );
  }

  void goBack() => Get.back();
}
