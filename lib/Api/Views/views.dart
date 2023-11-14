import 'package:untitled/Api/Models/categoriesmodel.dart';
import 'package:untitled/Api/Repositories/newsrepository.dart';

import '../Models/channelmodel.dart';

class NewsViewModel{
  final _rep =NewsRepository();
  Future<Bbc>fetchnews(name)async{
    final response = await _rep.fetchnews(name);
    return response;
  }
  Future<CategoriesNewsModel>fetchcateogory(String category)async{
    final response = await _rep.fetchcategory(category);
    return response;
  }
}