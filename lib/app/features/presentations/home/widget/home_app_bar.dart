import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flag/app/common/constants/text_constant.dart';
import 'package:rate_flag/app/common/widget/buttons/common_icon_button.dart';
import 'package:rate_flag/app/features/presentations/home/cubit/home_cubit.dart';
import 'package:rate_flag/app/features/presentations/home/cubit/home_state.dart';
import 'package:rate_flag/app/features/presentations/home/widget/tab_item.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final VoidCallback onTapMap;
  final VoidCallback onTapFeed;
  final VoidCallback onTapSearch;
  const HomeAppBar({
    super.key,
    required this.onPressed,
    required this.onTapMap,
    required this.onTapFeed,
    required this.onTapSearch,
  });

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
        onPressed: onPressed,
      ),
      title: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tabitem(
                title: TextConstants.map,
                isActive: state.selectedTab == HomeTab.map,
                onTap: onTapMap,
              ),
              const SizedBox(width: 20),
              Tabitem(
                title: TextConstants.forYou,
                isActive: state.selectedTab == HomeTab.forYou,
                onTap: onTapFeed,
              ),
            ],
          );
        },
      ),
      actions: [CommonIconButton(icon: Icons.search, onPressed: onTapSearch)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
