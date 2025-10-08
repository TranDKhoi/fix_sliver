import 'package:flutter/material.dart';

class ProjectFilterBar extends StatelessWidget {
  final Function(bool) onOverlapChanged;

  const ProjectFilterBar({
    super.key,
    required this.onOverlapChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFilterBarDelegate(
        filterBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(label: 'All'),
                      _FilterChip(label: 'Available'),
                      _FilterChip(label: 'Sold'),
                      _FilterChip(label: 'Reserved'),
                      _FilterChip(label: 'Penthouse'),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt_outlined),
              ),
            ],
          ),
        ),
        onOverlapChanged: onOverlapChanged,
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;

  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        onSelected: (_) {},
      ),
    );
  }
}

class _SliverFilterBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget filterBar;
  final Function(bool) onOverlapChanged;
  bool _lastOverlaps = false;

  _SliverFilterBarDelegate({
    required this.filterBar,
    required this.onOverlapChanged,
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
      elevation: overlapsContent ? 4 : 0,
      shadowColor: Colors.black,
      child: filterBar,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverFilterBarDelegate oldDelegate) => true;
}
