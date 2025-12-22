import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/get_it/service_locator.dart';
import 'package:rate_flag/features/RateFlag/common/widgets/buttons/common_icon_button.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/cubit/filter_page_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/view/filter_page_screen.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/cubit/home_state.dart';
import 'package:rate_flag/features/RateFlag/presentaions/home/widget/tabItem.dart';
import 'package:rate_flag/features/RateFlag/presentaions/notificaiton/cubit/notification_cubit.dart';
import 'package:rate_flag/features/RateFlag/presentaions/notificaiton/view/notification_screen.dart';

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
      leading: CommonIconButton(
        icon: Icons.notifications_none,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => getIt<NotificationCubit>(),
                child: NotificationScreen(),
              ),
            ),
          );
        },
      ),
      title: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tabitem(
                title: TextConstants.map,
                isActive: state.selectedTab == HomeTab.map,
                onTap: () => context.read<HomeCubit>().selectMap(),
              ),
              const SizedBox(width: 20),
              Tabitem(
                title: TextConstants.forYou,
                isActive: state.selectedTab == HomeTab.forYou,
                onTap: () => context.read<HomeCubit>().selectForYou(),
              ),
            ],
          );
        },
      ),
      actions: [
        CommonIconButton(
          icon: Icons.search,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => getIt<FilterPageCubit>()
                    ..loadAllUsers()
                    ..loadPosts(),
                  child: const FilterPageScreen(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
