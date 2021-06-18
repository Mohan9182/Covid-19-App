import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive/responsive.dart';
import 'package:responsive/responsive_row.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class InAppViewNews extends StatefulWidget{
  
  var link;
  
  InAppViewNews({Key key,
  @required this.link
  }):super(key: key);

  @override
  _InAppViewNews createState() => _InAppViewNews();
}
class _InAppViewNews extends State<InAppViewNews>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(22, 22, 37, 1),
        primaryColor: Color.fromRGBO(22, 22, 37, 1),

      ),
      home: Scaffold(
        appBar: AppBar(
          title: ResponsiveRow(
            children:[
              InkWell(
                child:FlexWidget(
                  child: Icon(UniconsLine.arrow_left,size: 30),
                  xs: 1,
                  md: 1,
                  lg: 2,
                  xl: 2,
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              FlexWidget(
                child:Container(
                  child:Text("News",style: GoogleFonts.oswald(fontSize: 21),),
                  alignment: Alignment.center,
                ),
                xs: 5,
                xl: 5,
                md: 9,
                lg: 9,
              ),
            ]
          )
        ),
        body: ResponsiveRow(
            children: [
              FlexWidget(
                child:Container(
                  child:InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.link)),
                  ),
                  width: 400,
                  height: 800,
                ),
                xs: 12,
                lg: 12,
                md: 12,
                xl: 12,
              )
            ]
        )
      )
    );
  }
}