import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/rate_flag/core/internet/cubit/internet_cubit.dart';
import 'package:rate_flag/features/rate_flag/core/internet/cubit/internet_state.dart';

class InternetGate extends StatelessWidget {
  final Widget child;
  const InternetGate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is NetworkConnected) {
          return child;
        }

        if (state is NetworkDisconnected) {
          return Scaffold(body: Center(child: Text("İnternet yok")));
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
