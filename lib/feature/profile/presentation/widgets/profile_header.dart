import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  final String? imageUrl;
  final File? localImage;
  final String? name;
  final VoidCallback? onImageEdit;

  const ProfileHeader({
    super.key,
    this.imageUrl,
    this.localImage,
    this.name,
    this.onImageEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 100.r,
              height: 100.r,
              decoration: const BoxDecoration(
                color: AppColors.gray10,
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: localImage != null
                  ? Image.file(localImage!, fit: BoxFit.cover)
                  : (imageUrl != null && imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset(AppAssets.defaultProfile, fit: BoxFit.cover),
                        )
                      : Image.asset(AppAssets.defaultProfile, fit: BoxFit.cover)),
            ),
            GestureDetector(
              onTap: onImageEdit,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 20.r,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (name != null)
          Text(
            name!,
            style: AppFontStyle.semiBold18(context),
          ),
      ],
    );
  }
}
