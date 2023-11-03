import 'package:untitled/Api/newsrepository.dart';

import 'model.dart';

class NewsViewModel{
  final _rep =NewsRepository();
  Future<Bbc>fetchnews()async{
    final response = await _rep.fetchnews();
    return response;
  }
}