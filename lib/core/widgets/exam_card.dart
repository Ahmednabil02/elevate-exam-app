import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ExamCard extends StatelessWidget {
  final String title;
  final String level;
  final int questionCount;
  final int durationMinutes;
  final Widget image;
  final VoidCallback onTap;

  const ExamCard({
    super.key,
    required this.title,
    required this.level,
    required this.questionCount,
    required this.durationMinutes,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image container
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: image,
                ),
              ),
              const SizedBox(width: 16),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          level,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.gray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '$durationMinutes Minutes',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$questionCount Question',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
