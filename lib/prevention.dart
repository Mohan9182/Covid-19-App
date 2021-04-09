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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: ResponsiveRow(
                    children: [
                      FlexWidget(
                        child: Container(
                            child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_left_outlined,
                                    size: 35),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                })),
                        xs: 1,
                        md: 1,
                        lg: 1,
                        xl: 1,
                      ),
                      FlexWidget(
                        child: Container(
                            child: Text('Prevention',
                                style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                )),
                            alignment: Alignment.center),
                        xs: 11,
                        md: 11,
                        lg: 11,
                        xl: 11,
                      )
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
                ),
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
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
