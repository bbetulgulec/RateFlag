import 'package:flutter/material.dart';

class PageListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;

  const PageListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder:
          separatorBuilder ??
          (context, index) => const Divider(
            thickness: 1,
            height: 1,
            color: Colors.grey,
            indent: 10,
            endIndent: 10,
          ),
    );
  }
}
