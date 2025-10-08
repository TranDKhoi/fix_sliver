import 'package:flutter/material.dart';

class TabProjectUnitList extends StatefulWidget {
  const TabProjectUnitList({super.key});

  @override
  State<TabProjectUnitList> createState() => _TabProjectUnitListState();
}

class _TabProjectUnitListState extends State<TabProjectUnitList> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverList.separated(
        itemCount: 30,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) => Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Text('Unit Item #$index')),
        ),
      ),
    );
  }
}
