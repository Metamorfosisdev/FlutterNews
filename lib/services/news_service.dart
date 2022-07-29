import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/models/new_model.dart';
import 'package:http/http.dart' as http;
/*
 * URL to call:
 * https://newsapi.org/v2/top-headlines?country=mx&apiKey=f75437b884d54f6c9dc25549952859bb
 * to remember the order of the arguments doesnt affect the call
 */

class NewsService extends ChangeNotifier {
  List<Article> headLines = [];
  final _urlbase = 'newsapi.org';
  final _apiKey = 'f75437b884d54f6c9dc25549952859bb';

  //Map to storage articles for a type of category
  String _selectedCategory = 'business';
  String get selectedCategory => _selectedCategory;

  set selectedCategory(String selectedCategory) {
    _selectedCategory = selectedCategory;
    getCategorySelected(selectedCategory);
    notifyListeners();
  }

  //Method to get selectedCategory

  Map<String, List<Article>> categoriesArticle = {};

  List<CategoryModel> categories = [
    CategoryModel('business', FontAwesomeIcons.building),
    CategoryModel('entertainment', FontAwesomeIcons.tv),
    CategoryModel('general', FontAwesomeIcons.addressCard),
    CategoryModel('health', FontAwesomeIcons.headSideVirus),
    CategoryModel('science', FontAwesomeIcons.vials),
    CategoryModel('sports', FontAwesomeIcons.volleyball),
    CategoryModel('technology', FontAwesomeIcons.building),
  ];
  //
  NewsService() {
    getTopHeadLines();
    //Inicializar el mapa de todas las categorias con una lista vacia
    _selectedCategory = 'business';
    categories.forEach((element) {
      categoriesArticle[element.name] = <Article>[];
    });
    getArticlesSelected;
    getCategorySelected(_selectedCategory);
  }

  List<Article> get getArticlesSelected {
    return categoriesArticle[_selectedCategory]!;
  }

  //Method to get the topHeadLines
  Future getTopHeadLines() async {
    Map<String, dynamic> queryParameters = {
      'country': 'mx',
      'apiKey': _apiKey,
    };
    final url = Uri.https(_urlbase, '/v2/top-headlines', queryParameters);
    final resp = await http.get(url);

    final newsResponse = NewsModel.fromJson(resp.body);

    headLines.addAll(newsResponse.articles);

    notifyListeners();
  }

  //Method to get articles by category
  Future getCategorySelected(String category) async {
    if (categoriesArticle[category]!.isNotEmpty) {
      return categoriesArticle[category]!;
    }
    Map<String, dynamic> queryParameters = {
      'country': 'mx',
      'apiKey': _apiKey,
      'category': category,
    };
    final url = Uri.https(_urlbase, '/v2/top-headlines', queryParameters);
    final resp = await http.get(url);

    //Para almacenar en cada categoria la lista encontrada
    final newsResponse = NewsModel.fromJson(resp.body);

    categoriesArticle[category]!.addAll(newsResponse.articles);

    // headLines.addAll(newsResponse.articles);

    notifyListeners();
  }
}
