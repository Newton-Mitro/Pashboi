import 'package:flutter/material.dart';
import 'package:pashboi/core/utils/app_context.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  SliverAppBarDelegate(TabBar tabBar) : _tabBar = tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(color: context.theme.colorScheme.secondary, child: _tabBar);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
