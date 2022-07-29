import 'package:flutter/material.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:newsapp/widgets/news_list.dart';
import 'package:provider/provider.dart';

class TabOneScreen extends StatefulWidget {
  static const String route = '/TabOneScreen';
  const TabOneScreen({Key? key}) : super(key: key);

  @override
  State<TabOneScreen> createState() => _TabOneScreenState();
}

class _TabOneScreenState extends State<TabOneScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    NewsService newsService = Provider.of<NewsService>(context);
    return (newsService.headLines.isEmpty)
        ? const Center(
            child: CircularProgressIndicator(
            color: Color(0xff46A094),
          ))
        : NewsList(headlines: newsService.headLines);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
