import 'dart:async';
import 'package:fix_sliver/home/widgets/tab_project_detail.dart';
import 'package:flutter/material.dart';
import 'widgets/project_appbar.dart';
import 'widgets/project_info.dart';
import 'widgets/tab_project_unit_list.dart';
import 'widgets/project_filter_bar.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _projectTitleKey = GlobalKey();
  final GlobalKey _projectUnitListKey = GlobalKey();

  double _pinnedAppbarOpacity = 0.0;
  bool _showAppBarTitle = false;
  bool _headerOverlapped = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    /// this method is use to calculate when to show the pinned appbar
    final titleContext = _projectTitleKey.currentContext;
    if (titleContext != null) {
      final titleBox = titleContext.findRenderObject();
      if (titleBox is RenderBox) {
        final titlePos = titleBox.localToGlobal(Offset.zero).dy;
        final newOpacity =
            ((kToolbarHeight - titlePos) / kToolbarHeight).clamp(0.0, 1.0);
        final shouldShowTitle = newOpacity > 0.0;

        if (shouldShowTitle != _showAppBarTitle ||
            newOpacity != _pinnedAppbarOpacity) {
          setState(() {
            _showAppBarTitle = shouldShowTitle;
            _pinnedAppbarOpacity = newOpacity;
          });
        }
      }
    }
  }

  // to show hide the View unit Button
  void _onTabChanged() {
    setState(() {});
  }

  Future<void> _handleChangeTab() async {
    _tabController.animateTo(0);
    _onScroll();

    final context = _projectUnitListKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context).then((_) {});
    }
  }

  void _onHeaderOverlap(bool value) {
    if (_headerOverlapped != value) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          setState(() => _headerOverlapped = value);
        },
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: _tabController.index == 1
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _handleChangeTab,
                child: const Text("View Unit"),
              ),
            )
          : null,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (_, __) => [
          ProjectAppBar(
            opacity: _pinnedAppbarOpacity,
            showTitle: _showAppBarTitle,
            showShadow: !_headerOverlapped,
          ),
          SliverToBoxAdapter(
            child: ProjectInfo(
              projectTitleKey: _projectTitleKey,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverTabBarDelegate(
              tabBar: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                tabs: const [
                  Tab(text: 'Units'),
                  Tab(text: 'Details'),
                ],
              ),
              filterBar: ProjectFilterBar(onFilterPressed: () {}),
              showFilter: _tabController.index == 0,
              onOverlapChanged: _onHeaderOverlap,
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            TabProjectUnitList(projectUnitListKey: _projectUnitListKey),
            const TabProjectDetail(),
          ],
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget tabBar;
  final Widget filterBar;
  final bool showFilter;
  final Function(bool) onOverlapChanged;
  bool _lastOverlaps = false;

  _SliverTabBarDelegate({
    required this.tabBar,
    required this.filterBar,
    required this.showFilter,
    required this.onOverlapChanged,
  });

  @override
  double get minExtent => kTextTabBarHeight + (showFilter ? 64 : 0);

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
      elevation: overlapsContent ? 4 : 0,
      shadowColor: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          tabBar,
          showFilter ? filterBar : const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) =>
      oldDelegate.showFilter != showFilter;
}
