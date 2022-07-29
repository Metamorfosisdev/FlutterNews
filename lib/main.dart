import 'package:flutter/material.dart';
import 'package:newsapp/providers/index_provider.dart';
import 'package:newsapp/screens/screens.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:newsapp/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IndexProvider()),
        ChangeNotifierProvider(
          create: (_) => NewsService(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: TabsScreen.route,
      theme: theme,
      routes: {
        TabsScreen.route: (context) => const TabsScreen(),
        TabOneScreen.route: (context) => const TabOneScreen(),
        TabTwoScreen.route: (context) => const TabTwoScreen(),
      },
    );
  }
}
