import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_cubit.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_event.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/manager/profile_state.dart';
import 'package:flowery_tracking_app/features/main_profile/presentation/widgets/custom_data.dart';
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
    return BlocProvider(
      create: (context) => profileCubit..doIntent(GetProfileEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization.profile),
          leading: const Icon(Icons.arrow_back_ios),
          actions: [
            IconButton(
              onPressed: () {},
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
                  return CustomData(
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.cyan,
                    ),
                    horizontalSpacing: 16,
                    firstText: state.driverDtoEntity?.firstName,
                    middleText: state.driverDtoEntity?.email,
                    lastText: state.driverDtoEntity?.photo,
                    iconDataTrailing: Icons.arrow_forward_ios,
                  );
                },
              ),
              verticalSpace(24),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return CustomData(
                    firstText: context.localization.vehicle_info,
                    middleText: state.driverDtoEntity?.vehicleType,
                    lastText: state.driverDtoEntity?.vehicleNumber,
                    iconDataTrailing: Icons.arrow_forward_ios,
                  );
                },
              ),
              verticalSpace(24),
              Row(
                children: [
                  const Icon(Icons.translate, size: 24),
                  horizontalSpace(4),
                  Text(
                    context.localization.language,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      /// localization action
                    },
                    child: Text(
                      context.localization.english,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.pink),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.logout, size: 24),
                  horizontalSpace(4),
                  Text(
                    context.localization.language,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      /// logout action
                    },
                    icon: const Icon(Icons.logout, size: 24),
                  ),
                ],
              ),
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
