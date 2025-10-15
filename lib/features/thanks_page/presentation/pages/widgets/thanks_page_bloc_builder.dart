import 'package:flowery_tracking_app/config/theme/colors.dart';
import 'package:flowery_tracking_app/core/helpers/spacing.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_cubit.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_event.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/manger/cubit/thanks_state.dart';
import 'package:flowery_tracking_app/features/thanks_page/presentation/pages/widgets/thanks_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThanksPageBlocBuilder extends StatefulWidget {
  const ThanksPageBlocBuilder({super.key, required this.orderId});
  final String orderId;

  @override
  State<ThanksPageBlocBuilder> createState() => _ThanksPageBlocBuilderState();
}

class _ThanksPageBlocBuilderState extends State<ThanksPageBlocBuilder> {
  @override
  void initState() {
    context.read<ThanksCubit>().doIntent(
      InitialThanksEvent(orderId: widget.orderId),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThanksCubit, ThanksState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.pink),
            ),
          );
        }
        if (state.errorMessage.isNotEmpty) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text(state.errorMessage),
                  verticalSpace(20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ThanksCubit>().doIntent(
                        InitialThanksEvent(orderId: widget.orderId),
                      );
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ),
          );
        }
        return const ThanksPageBody();
      },
    );
  }
}
