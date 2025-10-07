import 'package:flutter/material.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({
    super.key,
    required this.projectTitleKey,
  });

  final GlobalKey projectTitleKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key: projectTitleKey,
            'Project name here',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This is some static content above the list. You can put any details here like description, tags, or statistics.',
          ),
          const SizedBox(height: 16),
          const Text(
            'Show project info?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This is some static content above the list. You can put any details here like description, tags, or statistics.',
          ),
          const SizedBox(height: 16),
          const Text(
            'Project map?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This is some static content above the list. You can put any details here like description, tags, or statistics.',
          ),
          const SizedBox(height: 16),
          const Text(
            'About this project?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This is some static content above the list. You can put any details here like description, tags, or statistics.',
          ),
          const SizedBox(height: 16),
          const Text(
            'Some very long content?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This is some static content above the list. You can put any details here like description, tags, or statistics. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
