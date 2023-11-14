import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Api/Models/channelmodel.dart';
import 'package:untitled/Api/Repositories/newsrepository.dart';
import 'package:untitled/Api/Views/views.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/pages/categoryscreen.dart';

import '../Api/Models/categoriesmodel.dart';
import 'newsdetail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
enum FilterList{bbcNews,aryNews,independent,routers,cnn,alJazeera}

class _HomeState extends State<Home> {
  FilterList?selectedMenu;
  final format =DateFormat('MMMM,dd,yyyy');
  String name ='bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black ,
        leading:IconButton(onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoriesScreen()));
        },
          icon:Icon(Icons.category,color: Colors.white,)

        ),

        title: Text('News',style:GoogleFonts.poppins(fontSize:24,fontWeight: FontWeight.w700,color: Colors.white,)),
      actions: [
        PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert,color:Colors.white),
            onSelected: (FilterList item){
              if(FilterList.bbcNews.name==item.name){
                 name = 'bbc-news';
              }
              if(FilterList.alJazeera.name==item.name){
                name = 'al-jazeera-english';
              }
              if(FilterList.aryNews.name==item.name){
                name = 'ary-news';
              }
              
              setState(() {
                selectedMenu = item;
              });

            },
            itemBuilder:
        (BuildContext context) =><PopupMenuEntry<FilterList>>[
          PopupMenuItem<FilterList>(
            value: FilterList.bbcNews,
            child: Text('BBC News'),
          ),
          PopupMenuItem<FilterList>(
            value: FilterList.alJazeera,
            child: Text('alJazeera'),
          ),
          PopupMenuItem<FilterList>(
            value: FilterList.aryNews,
            child: Text('ary News'),
          ),
      ],
      ),
    ]
      ),
      body: ListView(
        children:[
          SizedBox(width:width,height:height*.55,
          child: FutureBuilder<Bbc>(
            future:NewsViewModel().fetchnews(name),
              builder: (BuildContext context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      )
                  );
                }
                else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
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
                      child: SizedBox(
                        child: Stack(
                          alignment:Alignment.center,
                          children:[
                          Container(
                          height:height*0.6,
                          width:width*0.9,
                          padding: EdgeInsets.symmetric(
                            horizontal: height*.02
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                              fit:BoxFit.cover,
                              placeholder: (context,url)=>Container(child:spinkit2,),
                              errorWidget:(context,url,error) =>Icon(Icons.error_outline,color: Colors.red,)
                            ),
                          ),
                        ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.all(15),
                                    height: height*.22,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width*0.7,
                                        child: Text(snapshot.data!.articles![index].title.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(fontSize:17,fontWeight:FontWeight.w700),),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: width*0.7,
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.articles![index].source!.name.toString(),
                                            maxLines:2,
                                            overflow:TextOverflow.ellipsis,
                                            style:GoogleFonts.poppins(fontSize:13,fontWeight:FontWeight.w600),
                                          ),
                                            Text(format.format(dateTime),
                                              maxLines:2,
                                              overflow:TextOverflow.ellipsis,
                                              style:GoogleFonts.poppins(fontSize:12,fontWeight:FontWeight.w500),
                                            ),


                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                      ]),
                          ),
                    );
                        });
                }
              },
          )
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModel>(
              future:NewsViewModel().fetchcateogory('General'),
              builder: (BuildContext context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      )
                  );
                }
                else {
                  return ListView.builder(
                    shrinkWrap: true,
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
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:15,),
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
                                    width: width*.9,
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
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ]
      ),
    );
  }
  static const spinkit2 = SpinKitFadingCircle(
    color: Colors.cyan,
    size: 50,
  );
}
