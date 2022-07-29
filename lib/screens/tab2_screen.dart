import 'package:flutter/material.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:newsapp/widgets/news_list.dart';
import 'package:provider/provider.dart';

class TabTwoScreen extends StatelessWidget {
  static const String route = '/TabTwoScreen';
  const TabTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Container(
                height: 100,
                width: size.width,
                child: _Categories(),
              ),
            ),
            Expanded(
              child: Container(
                child: NewsList(headlines: newsService.getArticlesSelected),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: newsService.categories.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            //Todo delete this print
            print(newsService.categories[index].name);
            newsService.selectedCategory = newsService.categories[index].name;
          },
          child: Container(
            width: 100,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (newsService.selectedCategory ==
                      newsService.categories[index].name)
                  ? const Color.fromARGB(255, 231, 96, 87)
                  : const Color(0xff46A094),
            ),
            //const Color(0xff46A094)
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Icon(newsService.categories[index].icon),
                const SizedBox(height: 10),
                _CategoryTitle(newsService: newsService, index: index),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CategoryTitle extends StatelessWidget {
  final int index;
  const _CategoryTitle({
    Key? key,
    required this.newsService,
    required this.index,
  }) : super(key: key);

  final NewsService newsService;

  @override
  Widget build(BuildContext context) {
    final category = newsService.categories[index].name[0].toUpperCase() +
        newsService.categories[index].name.substring(1);
    return Container(
      color: const Color(0xff6BBD99),
      width: 100,
      child: Text(
        category,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
