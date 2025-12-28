import 'package:flutter/material.dart';
import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';
import 'package:rate_flag/features/rate_flag/common/responsive/responsive.dart';
import 'package:rate_flag/features/rate_flag/core/enum/filter_list_type.dart';
import 'package:rate_flag/features/rate_flag/core/enum/request_status.dart';
import 'package:rate_flag/features/rate_flag/presentaions/filter_page/widget/search_result_tile.dart';
import '../cubit/filter_page_state.dart';

class FilterSearchList extends StatelessWidget {
  final FilterPageState state;

  const FilterSearchList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.userStatus == RequestStatus.loading ||
        state.postStatus == RequestStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    late final List<Widget> tiles;

    if (state.filterListType == FilterListType.users) {
      tiles = state.filteredUsers
          .map((user) => SearchResultTile(user: user))
          .toList();
    } else if (state.filterListType == FilterListType.posts) {
      tiles = state.filteredPosts
          .map((post) => SearchResultTile(post: post))
          .toList();
    } else {
      tiles = [];
    }

    if (tiles.isEmpty) {
      return const Center(child: Text(TextConstants.didNotFounduserAndPost));
    }

    return ListView(
      padding: EdgeInsets.only(top: 20.h),
      children: tiles,
    );
  }
}
