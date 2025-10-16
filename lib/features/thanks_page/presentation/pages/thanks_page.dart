import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_cubit.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/pages/widgets/thanks_page_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThanksPage extends StatelessWidget {
  ThanksPage({super.key, required this.orderId});
  final String orderId;
  final viewModel = getIt<ThanksCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => viewModel,
        child: ThanksPageBlocBuilder(orderId: orderId),
      ),
    );
  }
}
