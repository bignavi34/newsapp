import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Api/Models/categoriesmodel.dart';

import '../Api/Views/views.dart';
import 'home.dart';
import 'newsdetail.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final format =DateFormat('MMMM,dd,yyyy');
  String categoryName ='General';
  List<String>categoriesList=[
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Buisness',
    'Technology',
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        leading:IconButton(onPressed: () {
      Navigator.pop(context);
    },
    icon:Icon(Icons.arrow_back),
        color: Colors.white,),
        backgroundColor: Colors.black12,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(

          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(scrollDirection:Axis.horizontal,
                  itemCount:categoriesList.length,
                  itemBuilder:(context,index) {
                    return InkWell(
                        onTap: () {
                          categoryName = categoriesList[index];
                          setState(() {

                          }
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(decoration: BoxDecoration(
                              color: categoryName == categoriesList[index]
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12),
                              child: Center(child: Text(
                                categoriesList[index].toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.white
                                ),),),

                            ),),
                        )
                    );
                  }
            ),
            ),
            const SizedBox(height:20),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future:NewsViewModel().fetchcateogory(categoryName),
                builder: (BuildContext context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        )
                    );
                  }
                  else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return InkWell(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>NewsDetailScreen(
                                newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                newsTitle: snapshot.data!.articles![index].title.toString(),
                                newsDesc: snapshot.data!.articles![index].description.toString(),
                                newsSource: snapshot.data!.articles![index].source!.name.toString(),
                                newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                                newsUrl: snapshot.data!.articles![index].url.toString(),
                                newsAuthor: snapshot.data!.articles![index].author.toString(),
                                newsContent: snapshot.data!.articles![index].content.toString(),
                              )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:15,right: 10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                        imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                        fit:BoxFit.cover,
                                        height:height*.18,
                                        width:width*.25,
                                        placeholder: (context,url)=>Container(child:const Center(
                                            child: SpinKitCircle(
                                              size: 50,
                                              color: Colors.blue,
                                            )
                                        ),),
                                        errorWidget:(context,url,error) => Icon(Icons.error_outline,color: Colors.red,)
                                    ),
                                  ),
                                  SizedBox(width: 2,),
                                  Expanded(child: Container(
                                    height: height*.18,
                                    padding:const EdgeInsets.only(bottom:15),
                                    child:Column(
                                      children: [
                                        Text(snapshot.data!.articles![index].title.toString(),
                                        maxLines:3,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color:Colors.white,
                                          fontWeight: FontWeight.w700
                                        ),),
                                        Spacer(),
                                        Row(

                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.articles![index].source!.name.toString(),
                                              maxLines:3,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 5,
                                                  color:Colors.white,
                                                  fontWeight: FontWeight.w700
                                              ),),
                                            Text(format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500
                                              ),)

                                          ],
                                        )
                                      ],

                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            )
          ],

        ),
      ),
    );
  }
}
