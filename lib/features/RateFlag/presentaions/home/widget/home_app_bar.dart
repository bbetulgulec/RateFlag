import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: true,

      leading: const Icon(Icons.notifications_none, color: Colors.black),

      title: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _tabItem(
                title: "Map",
                isActive: state.selectedTab == HomeTab.map,
                onTap: () {
                  context.read<HomeCubit>().selectMap();
                },
              ),
              const SizedBox(width: 20),
              _tabItem(
                title: "For You",
                isActive: state.selectedTab == HomeTab.forYou,
                onTap: () {
                  context.read<HomeCubit>().selectForYou();
                },
              ),
            ],
          );
        },
      ),

      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.black),
        ),
      ],
    );
  }

  Widget _tabItem({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            width: isActive ? 24 : 0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
