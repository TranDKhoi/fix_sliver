import 'package:flutter/material.dart';

const appBarExpandedHeight = 300.0;

class ProjectAppBar extends StatelessWidget {
  final double opacity;
  final bool showTitle;
  final bool showShadow;

  const ProjectAppBar({
    super.key,
    required this.opacity,
    required this.showTitle,
    required this.showShadow,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: showShadow ? 4.0 : 0.0,
      surfaceTintColor: Colors.white,
      shadowColor: showShadow ? Colors.black : Colors.transparent,
      backgroundColor: Colors.white.withOpacity(opacity),
      leading: const BackButton(),
      title: AnimatedOpacity(
        opacity: showTitle ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: const Text('Project name here'),
      ),
      expandedHeight: appBarExpandedHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              'https://www.bigfootdigital.co.uk/wp-content/uploads/2020/07/image-optimisation-scaled.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Image thumbnails',
                style: TextStyle(
                  color: Colors.white,
                  height: 1.4,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
