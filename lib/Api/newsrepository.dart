import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';
class NewsRepository{
  Future<Bbc> fetchnews()async{
    String url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=99915a92931f4e97b3304eb3204aae3e";
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200){
      final body = jsonDecode(response.body);
      return Bbc.fromJson(body);
    }
    throw Exception('Error');

  }
}