import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/cubit/main_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/cubit/main_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/view/home_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/main/widget/bottom_bar.dart';
import 'package:rate_flag/features/RateFlag/presentaions/post/view/post_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/profile/view/profile_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> pages = const [
    HomeScreen(),
    PostPageView(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainCubit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            body: pages[state.currentIndex],

            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
              onPressed: () {
                context.read<MainCubit>().changeTab(1);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PostPageView()),
                );
              },
              child: const Icon(Icons.add, color: Colors.deepPurple, size: 30),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,

            bottomNavigationBar: BottomBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<MainCubit>().changeTab(index);
              },
            ),
          );
        },
      ),
    );
  }
}
