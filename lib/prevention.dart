import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive/responsive.dart';

// ignore: camel_case_types
class prevention extends StatelessWidget {
  const prevention({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Color.fromRGBO(22, 22, 37, 1),
            scaffoldBackgroundColor: Color.fromRGBO(22, 22, 37, 1)),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Covid-19 Tracker"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: ResponsiveRow(
                    children: [
                      FlexWidget(
                        child: Container(
                          child: Image.asset(
                            'assets/mask.png',
                            width: 90,
                            height: 90,
                          ),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          margin: EdgeInsets.all(10),
                        ),
                        xs: 4,
                        md: 4,
                        lg: 4,
                        xl: 4,
                      ),
                      FlexWidget(
                        child: Container(
                          child: Text(
                            'Wear mask',
                            style: GoogleFonts.oswald(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          padding: EdgeInsets.fromLTRB(20, 35, 0, 35),
                        ),
                        xs: 7,
                        md: 7,
                        lg: 7,
                        xl: 7,
                      )
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(18, 10, 15, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.greenAccent),
                ),
                Container(
                  child: ResponsiveRow(
                    children: [
                      FlexWidget(
                        child: Container(
                          child: Image.asset(
                            'assets/hands.png',
                            width: 90,
                            height: 90,
                          ),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          margin: EdgeInsets.all(10),
                        ),
                        xs: 4,
                        md: 4,
                        lg: 4,
                        xl: 4,
                      ),
                      FlexWidget(
                        child: Container(
                          child: Text(
                            'Wash hands',
                            style: GoogleFonts.oswald(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          padding: EdgeInsets.fromLTRB(20, 35, 0, 35),
                        ),
                        xs: 7,
                        md: 7,
                        lg: 7,
                        xl: 7,
                      )
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(18, 10, 15, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.greenAccent),
                ),
                Container(
                  child: ResponsiveRow(
                    children: [
                      FlexWidget(
                        child: Container(
                          child: Image.asset(
                            'assets/distance.png',
                            width: 90,
                            height: 90,
                          ),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          margin: EdgeInsets.all(10),
                        ),
                        xs: 4,
                        md: 4,
                        lg: 4,
                        xl: 4,
                      ),
                      FlexWidget(
                        child: Container(
                          child: Text(
                            'Maintain distance',
                            style: GoogleFonts.oswald(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          padding: EdgeInsets.fromLTRB(20, 35, 0, 35),
                        ),
                        xs: 7,
                        md: 7,
                        lg: 7,
                        xl: 7,
                      )
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(18, 10, 15, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.greenAccent),
                ),
                Container(
                  child: ResponsiveRow(
                    children: [
                      FlexWidget(
                        child: Container(
                          child: Image.asset(
                            'assets/home.png',
                            width: 90,
                            height: 90,
                          ),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        ),
                        xs: 4,
                        md: 4,
                        lg: 4,
                        xl: 4,
                      ),
                      FlexWidget(
                        child: Container(
                          child: Text(
                            'Stay home',
                            style: GoogleFonts.oswald(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          padding: EdgeInsets.fromLTRB(20, 35, 0, 35),
                        ),
                        xs: 7,
                        md: 7,
                        lg: 7,
                        xl: 7,
                      )
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(18, 10, 15, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.greenAccent),
                ),
                Container(
                  child: ResponsiveRow(
                    children: [
                      FlexWidget(
                        child: Container(
                          child: Image.asset(
                            'assets/doctor.png',
                            width: 90,
                            height: 90,
                          ),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          margin: EdgeInsets.all(10),
                        ),
                        xs: 4,
                        md: 4,
                        lg: 4,
                        xl: 4,
                      ),
                      FlexWidget(
                        child: Container(
                          child: Text(
                            'Consult doctor',
                            style: GoogleFonts.oswald(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          padding: EdgeInsets.fromLTRB(20, 35, 0, 35),
                        ),
                        xs: 7,
                        md: 7,
                        lg: 7,
                        xl: 7,
                      )
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(18, 10, 15, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.greenAccent),
                )
              ],
            ),
          ),
        ));
  }
}
