import 'package:flutter/material.dart';
import 'package:newsapp/providers/index_provider.dart';
import 'package:newsapp/screens/tab1_screen.dart';
import 'package:newsapp/screens/tab2_screen.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  static const String route = '/TasbScreen';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsService newsService = Provider.of<NewsService>(context);
    return const Scaffold(
      body: _Pages(),
      bottomNavigationBar: _NavigationBar(),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<IndexProvider>(context);
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      backgroundColor: const Color(0xff46A094),
      currentIndex: indexProvider.currentIndex,
      onTap: (index) {
        indexProvider.currentIndex = index;
      },
      items: const [
        BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.newspaper),
            label: 'Titulares'),
        BottomNavigationBarItem(
            icon: Icon(Icons.south_america_outlined), label: 'World'),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IndexProvider indexProvider = Provider.of<IndexProvider>(context);
    return PageView(
      //physics: const BouncingScrollPhysics(),
      controller: indexProvider.controller,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        TabOneScreen(),
        TabTwoScreen(),
      ],
    );
  }
}
