import 'package:flutter/material.dart';

class ProjectTabBar extends StatelessWidget {
  const ProjectTabBar({
    super.key,
    required this.tabController,
    required this.onOverlapChanged,
    required this.isFilterBarPinned,
  });

  final TabController tabController;
  final Function(bool) onOverlapChanged;
  final bool isFilterBarPinned;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverTabBarDelegate(
        tabBar: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(text: 'Units'),
            Tab(text: 'Details'),
          ],
        ),
        isFilterBarPinned: isFilterBarPinned,
        onOverlapChanged: onOverlapChanged,
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget tabBar;
  final Function(bool) onOverlapChanged;
  final bool isFilterBarPinned;
  bool _lastOverlaps = false;

  _SliverTabBarDelegate({
    required this.tabBar,
    required this.onOverlapChanged,
    required this.isFilterBarPinned,
  });

  @override
  double get minExtent => kTextTabBarHeight;

  @override
  double get maxExtent => minExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    if (_lastOverlaps != overlapsContent) {
      _lastOverlaps = overlapsContent;
      onOverlapChanged.call(overlapsContent);
    }

    return Material(
      color: Colors.white,
      elevation: !isFilterBarPinned && overlapsContent ? 4 : 0,
      shadowColor: Colors.black,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) => true;
}
