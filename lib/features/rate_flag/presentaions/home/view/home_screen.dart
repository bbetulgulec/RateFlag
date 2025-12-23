import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/view/feed_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/widget/home_app_bar.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/view/map_screen.dart';

import '../../../common/get_it/service_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(getIt(), getIt())..loadAllPosts(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const HomeAppBar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.selectedTab == HomeTab.map
                ? const MapScreen()
                : const FeedScreen();
          },
        ),
      ),
    );
  }
}
