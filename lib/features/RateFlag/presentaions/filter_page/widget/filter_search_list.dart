import 'package:flutter/material.dart';
import 'package:rate_flag/features/RateFlag/common/constants/text_constant.dart';
import 'package:rate_flag/features/RateFlag/common/responsive/responsive.dart';
import 'package:rate_flag/features/RateFlag/core/enum/request_status.dart';
import 'package:rate_flag/features/RateFlag/presentaions/filter_page/widget/search_result_tile.dart';
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

    final List<Widget> tiles = [];

    for (var user in state.filteredUsers) {
      tiles.add(SearchResultTile(user: user));
    }

    for (var post in state.filteredPosts) {
      tiles.add(SearchResultTile(post: post));
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
