import 'dart:async';
import 'package:fix_sliver/home/widgets/project_tab_bar.dart';
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
  bool _filterBarPinned = false;
  bool _tabBarPinned = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChangedListener);
    _scrollController.addListener(_onScrollListener);
  }

  void _onScrollListener() {
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

  // show hide the View unit Button
  // show hide filter bar, unit count
  void _onTabChangedListener() {
    setState(() {});
  }

  Future<void> _handleChangeTab() async {
    _tabController.animateTo(0);
    if (_projectUnitListKey.currentContext != null) {
      Scrollable.ensureVisible(
        _projectUnitListKey.currentContext!,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  void _onTabBarPinned(bool value) {
    if (_tabBarPinned != value) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          setState(() => _tabBarPinned = value);
        },
      );
    }
  }

  void _onFilterBarPinned(bool value) {
    if (_filterBarPinned != value) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          setState(() => _filterBarPinned = value);
        },
      );
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChangedListener);
    _tabController.dispose();
    _scrollController.removeListener(_onScrollListener);
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          /// background image and app bar
          ProjectAppBar(
            opacity: _pinnedAppbarOpacity,
            showTitle: _showAppBarTitle,
            showShadow: !_tabBarPinned,
          ),

          /// info section here
          SliverToBoxAdapter(
            child: ProjectInfo(
              projectTitleKey: _projectTitleKey,
            ),
          ),

          /// Tab bar
          ProjectTabBar(
            tabController: _tabController,
            isFilterBarPinned:
                _tabController.index == 1 ? false : _filterBarPinned,
            onOverlapChanged: _onTabBarPinned,
          ),

          /// work as a anchor so i can scroll to it
          SliverToBoxAdapter(
            child: SizedBox(
              key: _projectUnitListKey,
            ),
          ),

          /// filter bar and unit count
          if (_tabController.index == 0) ...[
            const SliverToBoxAdapter(
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Total 18 units",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            ProjectFilterBar(
              onOverlapChanged: _onFilterBarPinned,
            ),
          ],

          /// Tab Bar View Content here
          DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            sliver: Builder(
              builder: (context) {
                switch (_tabController.index) {
                  case 0:
                    return const TabProjectUnitList();
                  default:
                    return const TabProjectDetail();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
