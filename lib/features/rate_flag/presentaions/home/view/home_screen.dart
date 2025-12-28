import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/rate_flag/common/routes/routes.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/cubit/home_state.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/view/feed_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/view/map_screen.dart';
import 'package:rate_flag/features/rate_flag/presentaions/home/widget/home_app_bar.dart';
import '../../../common/get_it/service_locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(getIt(), getIt())..loadAllPosts(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: HomeAppBar(
              onPressed: () {
                Routes.push(context, Routes.notification);
              },
              onTapMap: () {
                context.read<HomeCubit>().selectMap();
              },
              onTapFeed: () {
                context.read<HomeCubit>().selectForYou();
              },
              onTapSearch: () {
                Routes.push(context, Routes.filterPage);
              },
            ),
            body: state.selectedTab == HomeTab.map
                ? const MapScreen()
                : const FeedScreen(),
          );
        },
      ),
    );
  }
}
