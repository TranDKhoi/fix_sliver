import 'package:flutter/material.dart';

class TabProjectDetail extends StatelessWidget {
  const TabProjectDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        ...List.generate(
          30,
          (index) => Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text('Detail info  #$index')),
          ),
        ),
      ],
    );
  }
}
