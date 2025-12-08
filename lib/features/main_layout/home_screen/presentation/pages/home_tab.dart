import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/presentation/widgets/shimmer/home_shimmer.dart';
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

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late ScrollController _scrollController;
  HomeTabViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom && _viewModel != null) {
      final state = _viewModel!.state;

      if (!state.isLoadingMore && state.hasMoreData) {
        _viewModel!.doIntent(
          GetAllPendingOrdersEvent(
            page: state.currentPage + 1,
            isLoadMore: true,
          ),
        );
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              context.pushReplacementNamed(AppRoutes.orderDetails);
            }
            if (state.errorSaveOrder != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorSaveOrder!)));
            }
          },
          builder: (context, state) {
            // Store the viewModel reference for use in scroll listener
            _viewModel = context.read<HomeTabViewModel>();

            return RefreshIndicator(
              key: _viewModel!.refreshIndicatorKey,
              onRefresh: () async {
                _viewModel!.doIntent(GetAllPendingOrdersEvent());
                await Future.delayed(const Duration(milliseconds: 500));
              },
              child: Builder(
                builder: (context) {
                  if (state.isLoadingGetOrders) {
                    return const HomeShimmerWidget();
                  } else if (state.errorGetOrders != null &&
                      state.orders.isEmpty) {
                    return Center(
                      child: OutlinedButton(
                        onPressed: () =>
                            _viewModel!.doIntent(GetAllPendingOrdersEvent()),
                        child: Text(context.localization.try_again),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        verticalSpace(context.height * 0.03),
                        Expanded(
                          child: ListView.separated(
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              if (index < state.orders.length) {
                                return PendingOrderCart(
                                  order: state.orders[index],
                                );
                              } else {
                                // Loading indicator at bottom
                                return state.isLoadingMore
                                    ? const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }
                            },
                            separatorBuilder: (context, index) =>
                                verticalSpace(16),
                            itemCount:
                                state.orders.length +
                                (state.isLoadingMore ? 1 : 0),
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
