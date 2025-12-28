import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_flag/features/rate_flag/common/constants/assets_path.dart';
import 'package:rate_flag/features/rate_flag/core/internet/cubit/internet_cubit.dart';
import 'package:rate_flag/features/rate_flag/core/internet/cubit/internet_state.dart';

class InternetScreen extends StatelessWidget {
  final Widget child;

  const InternetScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            if (state is NetworkDisconnected) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(AssetsPath.splash, width: 200),
                      const SizedBox(height: 16),
                      const Text(
                        'Şu an internete bağlı değilsiniz',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
