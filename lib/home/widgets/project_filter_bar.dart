import 'package:flutter/material.dart';

class ProjectFilterBar extends StatelessWidget {
  final VoidCallback? onFilterPressed;
  final GlobalKey? keyRef;

  const ProjectFilterBar({
    super.key,
    this.keyRef,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: keyRef,
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