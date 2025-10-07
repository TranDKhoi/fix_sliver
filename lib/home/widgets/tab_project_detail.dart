import 'package:flutter/material.dart';
import 'dart:math';

class TabProjectDetail extends StatelessWidget {
  const TabProjectDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              40,
              (index) => const Text("this is some very long text"),
            ),
          ],
        ),
      ),
    );
  }
}
