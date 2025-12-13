import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/widget/feed_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/widget/home_app_bar.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/widget/map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const HomeAppBar(),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.selectedTab == HomeTab.map) {
            return const MapScreen();
          }

          return FeedScreen();
        },
      ),
    );
  }
}
