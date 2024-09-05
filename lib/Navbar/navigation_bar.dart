import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_app/Posts/Image/image_post_Screen.dart';
import 'package:social_media_app/Posts/Text/text_post_Screen.dart';
import 'package:social_media_app/Posts/Video/video_post_Screen.dart';

class NavBar extends ConsumerStatefulWidget {
  const NavBar({super.key});

  @override
  ConsumerState<NavBar> createState() => _NavBarState();
}

class _NavBarState extends ConsumerState<NavBar> {
  List<Widget> pages = [
    const ImagePostScreen(),
    const VideoPostScreen(),
    const TextPostScreen(),
  ];

  final selectedIndex = StateProvider<int>((ref) => 0);
  void switchScreen(int index) {
    ref.read(selectedIndex.notifier).state = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: ref.read(selectedIndex),
          onTap: switchScreen,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.image), label: "Image"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library), label: "Video"),
            BottomNavigationBarItem(
                icon: Icon(Icons.text_snippet), label: "Text"),
          ]),
      body: pages[ref.watch(selectedIndex)],
    );
  }
}
