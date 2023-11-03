import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Api/model.dart';
import 'package:untitled/Api/newsrepository.dart';
import 'package:untitled/Api/views.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(onPressed: () {  },
          icon:Image.asset('images/category_icon.png',
          height:30,
          width:30)

        ),
        title: Text('News',style:GoogleFonts.poppins(fontSize:24,fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        children:[
          SizedBox(width:width,height:height*.55,
          child: FutureBuilder<Bbc>(
            future:NewsViewModel().fetchnews(),
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
                  return Container();
                }
              },
          )
          ),
        ]
      ),
    );
  }
}
