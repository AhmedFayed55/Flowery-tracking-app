import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/components/shimmer.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/utils/font_weight.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_event.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_state.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/manager/home_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/pending_order_cart.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeTabViewModel>()
        ..doIntent(GetAllPendingOrdersEvent())
        ..doIntent(GetLoggedDriverDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            context.localization.flowery_rider,
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: AppFontWeight.regular,
              color: AppColors.pink,
            ),
          ),
        ),
        body: BlocConsumer<HomeTabViewModel, HomeTabState>(
          listener: (context, state) {
            if (state.isOrderSaved) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: context.colorScheme.primary,
                  content: Text(context.localization.success_saved_order),
                ),
              );
              context.pushReplacementNamed(
                AppRoutes.orderDetails,
              );
            }
            if (state.errorSaveOrder != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorSaveOrder!)));
            }
          },
          builder: (context, state) {
            final viewModel = context.read<HomeTabViewModel>();

            return RefreshIndicator(
              key: viewModel.refreshIndicatorKey,
              onRefresh: () async {
                context.read<HomeTabViewModel>().doIntent(
                  GetAllPendingOrdersEvent(),
                );
                await Future.delayed(const Duration(milliseconds: 500));
              },
              child: Builder(
                builder: (context) {
                  if (state.isLoadingGetOrders) {
                    return const Column(children: [CustomShimmerWidget()]);
                  } else if (state.errorGetOrders != null) {
                    return Center(
                      child: OutlinedButton(
                        onPressed: () =>
                            viewModel.doIntent(GetAllPendingOrdersEvent()),
                        child: Text(context.localization.try_again),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        verticalSpace(context.height * 0.03),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) =>
                                PendingOrderCart(order: state.orders[index]),
                            separatorBuilder: (context, index) =>
                                verticalSpace(16),
                            itemCount: state.orders.length,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
