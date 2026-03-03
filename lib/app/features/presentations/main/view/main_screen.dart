import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/core/get_it/service_locator.dart';
import 'package:rate_flag/core/responsive/responsive.dart';
import 'package:rate_flag/core/routes/routes.dart';
import 'package:rate_flag/app/features/presentations/main/cubit/main_cubit.dart';
import 'package:rate_flag/app/features/presentations/main/cubit/main_state.dart';
import 'package:rate_flag/app/features/presentations/home/view/home_screen.dart';
import 'package:rate_flag/app/features/presentations/main/widget/bottom_bar.dart';
import 'package:rate_flag/app/features/presentations/profile/cubit/profile_cubit.dart';
import 'package:rate_flag/app/features/presentations/profile/view/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MainCubit>()),
        BlocProvider(create: (_) => getIt<ProfileCubit>()),
      ],
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          final pages = [const HomeScreen(), const ProfileScreen()];

          return Scaffold(
            extendBody: true,
            body: pages[state.currentIndex],
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 4,
              onPressed: () {
                Routes.push(context, Routes.post);
              },
              child: Icon(Icons.add, color: Colors.white, size: 30.sp),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomBar(
              currentIndex: state.currentIndex,
              onTap: (index) => context.read<MainCubit>().changeTab(index),
            ),
          );
        },
      ),
    );
  }
}
