import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCard extends StatelessWidget {
  const CallCard({
    super.key,
    required this.phoneNumber,
    required this.title,
    required this.address,
    required this.imgeUrl,
  });
  final String phoneNumber;
  final String title;
  final String address;
  final String imgeUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white[10],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.shade100.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,

              backgroundColor: AppColors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.network(
                  fit: BoxFit.cover,
                  height: 44,
                  width: 44,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, color: AppColors.pink, size: 30),
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                      ? child
                      : const CircularProgressIndicator(color: AppColors.pink),
                  imgeUrl.contains('http') || imgeUrl.contains('https')
                      ? imgeUrl
                      : 'https://flower.elevateegy.com/uploads/$imgeUrl',
                ),
              ),
            ),
            horizontalSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black.withValues(alpha: 0.4),
                  ),
                ),
                verticalSpace(4),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.locationIcon,
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    horizontalSpace(4),
                    Text(
                      address,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),
            GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse("tel:$phoneNumber");
                if (!await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch $url');
                }
              },
              child: const Icon(
                Icons.call_outlined,
                color: AppColors.pink,
                size: 16,
              ),
            ),
            horizontalSpace(8),
            GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse("https://wa.me/$phoneNumber");
                if (!await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch $url');
                }
              },

              child: SvgPicture.asset(
                AppAssets.whatsAppIcon,
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
