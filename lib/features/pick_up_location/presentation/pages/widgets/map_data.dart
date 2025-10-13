import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/user_entity.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/call_card.dart';
import 'package:flutter/material.dart';

class MapData extends StatelessWidget {
  const MapData({super.key, required this.user, required this.store});
  final UserEntity user;
  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    final size24height = context.height * 0.03;
    final size16height = context.height * 0.016;
    final size65height = context.height * 0.065;
    final size8height = context.height * 0.008;
    var trans = context.localization;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size16height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          horizontalSpace(size16height),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size65height,
                height: size8height / 2,
                decoration: BoxDecoration(
                  color: AppColors.pink,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          verticalSpace(size24height),
          Text(
            trans.pickup_location,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          verticalSpace(size8height),

          CallCard(
            phoneNumber: store.phoneNumber!,
            title: store.name!,
            address: store.address!,
            imgeUrl: store.image!,
          ),
          verticalSpace(size16height),
          Text(
            trans.user_location,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          verticalSpace(size8height),

          CallCard(
            phoneNumber: user.phone!,
            title: '${user.firstName!} ${user.lastName!}',
            address: '20th st, Sheikh Zayed, Giza',
            imgeUrl: user.photo!,
          ),
        ],
      ),
    );
  }
}
