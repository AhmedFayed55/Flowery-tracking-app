import 'package:flowery_tracking_app/config/routing/app_routes.dart';
import 'package:flowery_tracking_app/config/routing/routing_extensions.dart';
import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/core/extensions/extensions.dart';
import 'package:flowery_tracking_app/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/core/utils/enums.dart' hide OrderStatus;
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_cubit.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/manger/cubit/order_details_event.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/call_card.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/custom_change_order_status_bottom.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/details_widget.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/order_details_shimmer.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/order_status.dart';
import 'package:flowery_tracking_app/features/order_details/presentation/pages/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../manger/cubit/order_details_state.dart';

class OrderDetailsBody extends StatefulWidget {
  const OrderDetailsBody({super.key});

  @override
  State<OrderDetailsBody> createState() => _OrderDetailsBodyState();
}

class _OrderDetailsBodyState extends State<OrderDetailsBody> {
  @override
  void initState() {
    var orderId = getIt<SharedPrefHelper>().getData(key: AppConstants.orderId);
    context.read<OrderDetailsCubit>().doIntent(
      GetOrderDetailsEvent(orderId: orderId as String),
    );
    super.initState();
  }

  String formatIsoToReadableDate(String isoDate) {
    try {
      DateTime dateTime = DateTime.parse(isoDate).toLocal();
      return DateFormat("EEE, dd MMM yyyy, hh:mm a").format(dateTime);
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    var padding16width = context.width * 0.043;
    var padding4width = context.width * 0.01;
    var size24height = context.height * 0.025;
    var size16height = context.height * 0.016;
    var size8height = context.height * 0.008;
    var trans = context.localization;
    var order = context.watch<OrderDetailsCubit>().state.orderDetails;
    return BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          DialogueUtils.showAlertDialog(context, state.errorMessage!);
        }
        if (state.isOrderCompleted) {
          context.pushReplacementNamed(
            AppRoutes.thanksPage,
            arguments: state.orderDetails!.id,
          );
        }
      },
      builder: (context, state) {
        if (state.isSceenLoading) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () =>
                    context.pushReplacementNamed(AppRoutes.mainLayout),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              title: Text(trans.orderDetails),
            ),
            body: const OrderDetailsShimmer(),
          );
        }
        return Scaffold(
          bottomNavigationBar: const CustomChangeOrderStatusBottom(),
          appBar: AppBar(
            leading: state.riderOrderStatus == RiderOrderStatus.delivered
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () =>
                        context.pushReplacementNamed(AppRoutes.mainLayout),
                  )
                : const SizedBox(),
            title: Text(trans.orderDetails),
            scrolledUnderElevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding16width),
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepProgressIndicator(
                    padding: padding4width,

                    roundedEdges: const Radius.circular(3),
                    totalSteps: 5,
                    currentStep: state.riderOrderStatus?.statusStep ?? 0,
                    selectedColor: AppColors.green,
                  ),
                  verticalSpace(size24height),

                  OrderStatus(
                    orderId: order!.orderNumber!,
                    date: formatIsoToReadableDate(order.createdAt!),
                  ),

                  verticalSpace(size16height),
                  Text(
                    trans.pickupAddress,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  verticalSpace(size16height),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoutes.pickupLocation , arguments: {
                        "user": order.user,
                        "store": order.store
                      });
                    },
                    child: CallCard(
                      phoneNumber: order.store!.phoneNumber!,
                      title: order.store!.name!,
                      address: order.store!.address!,
                      imgeUrl: order.store!.image!,
                    ),
                  ),
                  verticalSpace(size24height),
                  Text(
                    trans.userAddress,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  verticalSpace(size16height),

                  CallCard(
                    phoneNumber: order.user!.phone!,
                    title: '${order.user!.firstName!} ${order.user!.lastName!}',
                    address: "20th st, Sheikh Zayed, Giza ",
                    imgeUrl: order.user!.photo!,
                  ),
                  verticalSpace(size24height),
                  Text(
                    trans.orderDetailsSection,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  verticalSpace(size16height),
                  state.orderDetails!.orderItems!.isNotEmpty
                      ? ListView.builder(
                          itemCount: order.orderItems!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ProductCard(
                              orderItems: order.orderItems![index],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  verticalSpace(size24height),
                  DetailsWidget(
                    firstText: trans.total,
                    secondText: '${trans.egp} ${order.totalPrice}',
                  ),
                  verticalSpace(size16height),
                  DetailsWidget(
                    firstText: trans.paymentMethod,
                    secondText: order.isPaid ?? false
                        ? trans.paid
                        : trans.cashOnDelivery,
                  ),
                  verticalSpace(size8height),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
