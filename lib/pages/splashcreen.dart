import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _splashState();
}

class _splashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));

    });
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).height*1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child:Center(
          child: Text('Daily News',style:GoogleFonts.poppins(fontSize:30,fontWeight: FontWeight.w700,color: Colors.white,)),
        )

      ),
    );
  }
}
