import 'package:flutter/material.dart';
import '../models/coloring_page.dart';
import 'coloring_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = ColoringPage.samples();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kids Coloring Book 🎨'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: pages.length,
        itemBuilder: (_, i) {
          final page = pages[i];
          return _PreviewTile(
            title: page.title,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ColoringScreen(page: page.clone()),
              ));
            },
          );
        },
      ),
    );
  }
}

class _PreviewTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _PreviewTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.purple.withOpacity(.08)],
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
