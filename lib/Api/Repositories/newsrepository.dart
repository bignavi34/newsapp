import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/pages/home.dart';

import '../Models/categoriesmodel.dart';
import '../Models/channelmodel.dart';
class NewsRepository{
  Future<Bbc> fetchnews(String channelname)async{
    String url = "https://newsapi.org/v2/top-headlines?sources=$channelname&apiKey=99915a92931f4e97b3304eb3204aae3e";
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200){
      final body = jsonDecode(response.body);
      return Bbc.fromJson(body);
    }
    throw Exception('Error');

  }
  Future<CategoriesNewsModel> fetchcategory(String categoryname)async {
    String url = "https://newsapi.org/v2/everything?q=$categoryname&sortBy=publishedAt&apiKey=99915a92931f4e97b3304eb3204aae3e";
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}