import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/app_typography.dart';
import 'package:goals/view_models/developer_viewmodel.dart';
import 'package:goals/widgets/developer/developer_bio_card.dart';
import 'package:goals/widgets/developer/developer_contact_card.dart';
import 'package:goals/widgets/developer/developer_profile_header.dart';

class DeveloperView extends StatelessWidget {
  const DeveloperView({super.key});

  @override
  Widget build(BuildContext context) {
    final DeveloperViewModel viewModel = Get.put(DeveloperViewModel());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: InkWell(
              onTap: viewModel.goBack,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textMain,
                  size: 18,
                ),
              ),
            ),
          ),
          title: Text(
            'عن المطور',
            style: AppTypography.displayMedium.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.textMain,
            ),
          ),
          centerTitle: true,
          actions: const [SizedBox(width: 56)],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            DeveloperProfileHeader(
              name: viewModel.developerName,
              role: viewModel.developerRole,
            ),

            const SizedBox(height: 18),

            DeveloperBioCard(bio: viewModel.developerBio),

            const SizedBox(height: 18),

            DeveloperContactCard(
              onWhatsAppTap: viewModel.openWhatsApp,
              onInstagramTap: viewModel.openInstagram,
              instagramHandle: viewModel.instagramHandle,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
