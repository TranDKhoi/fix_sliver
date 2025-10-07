import 'package:flutter/material.dart';

class TabProjectUnitList extends StatefulWidget {
  const TabProjectUnitList({
    super.key,
    required this.projectUnitListKey,
  });

  final GlobalKey projectUnitListKey;

  @override
  State<TabProjectUnitList> createState() => _TabProjectUnitListState();
}

class _TabProjectUnitListState extends State<TabProjectUnitList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ColoredBox(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              key: widget.projectUnitListKey,
              "Total 18 units",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            ...List.generate(
              20,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('Unit Item #$index')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
