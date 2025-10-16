import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/general_cubits/locale_cubit.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_view_model.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_event.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_state.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/custom_action_row.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/custom_info_card.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/dialog_change_locale.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainProfile extends StatefulWidget {
  const MainProfile({super.key});

  @override
  State<MainProfile> createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  final ProfileCubit profileCubit = getIt.get<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    final currentLang = context.read<LocaleCubit>().state.languageCode;
    return BlocProvider(
      create: (context) => profileCubit..doIntent(GetProfileEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization.profile),
          leading: const Icon(Icons.arrow_back_ios),
          actions: [
            IconButton(
              onPressed: () {
                /// Notification action
              },
              icon: const Badge(child: Icon(Icons.notifications_none)),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 31, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Container(
                      alignment: Alignment.center,
                      height: context.height * 0.13,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            spreadRadius: 2,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      child: const CircularProgressIndicator(),
                    );
                  } else {
                    return CustomInfoCard(
                      leading: const CircleAvatar(
                        radius: 35,

                        /// when add image to profile
                        // backgroundImage: ,
                        backgroundColor: AppColors.pink,
                      ),

                      horizontalSpacing: 16,
                      firstText: state.driverDtoEntity?.firstName,
                      middleText: state.driverDtoEntity?.email,
                      lastText: state.driverDtoEntity?.phone,
                      iconDataTrailing: Icons.arrow_forward_ios,
                    );
                  }
                },
              ),
              verticalSpace(24),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Container(
                      alignment: Alignment.center,
                      height: context.height * 0.13,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            spreadRadius: 2,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      child: const CircularProgressIndicator(),
                    );
                  } else {
                    return CustomInfoCard(
                      firstText: context.localization.vehicle_info,
                      middleText: state.driverDtoEntity?.vehicleType
                          ?? context.localization.vehicle_not_found,
                      lastText: state.driverDtoEntity?.vehicleNumber,
                      iconDataTrailing: Icons.arrow_forward_ios,
                    );
                  }
                },
              ),
              verticalSpace(24),
              CustomActionRow(
                icon: Icons.translate,
                title: context.localization.language,
                trailing: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => const DialogChangeLocale(),
                    );
                  },
                  child: Text(
                    currentLang == AppConstants.enKey
                        ? context.localization.english
                        : context.localization.arabic,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.pink),
                  ),
                ),
              ),
              const LogoutButton(),
              const Spacer(),
              Text(
                context.localization.app_version,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
