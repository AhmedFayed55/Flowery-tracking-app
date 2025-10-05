import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
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
    var padding16width = context.width * 0.043;
    var size16height = context.height * 0.016;
    var size20height = context.height * 0.0199;
    var size44height = context.height * 0.044;
    var size8height = context.height * 0.008;
    var size4height = context.height * 0.004;
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
        padding: EdgeInsets.all(padding16width),
        child: Row(
          children: [
            CircleAvatar(
              radius: size44height / 2,

              backgroundColor: AppColors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.network(
                  fit: BoxFit.cover,
                  height: size44height,
                  width: size44height,
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
            horizontalSpace(size8height),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: size16height,
                    color: AppColors.black.withValues(alpha: 0.4),
                  ),
                ),
                verticalSpace(size4height),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.locationIcon,
                      width: size16height,
                      height: size16height,
                      colorFilter: const ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    horizontalSpace(size4height),
                    Text(
                      address,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.black,
                        fontSize: size16height,
                      ),
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
              child: Icon(
                Icons.call_outlined,
                color: AppColors.pink,
                size: size16height,
              ),
            ),
            horizontalSpace(size8height),
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
                width: size20height,
                height: size20height,
              ),
            ),
          ],
        ),
      ),
    );
  }
}