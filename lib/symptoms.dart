import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive/responsive.dart';

// ignore: camel_case_types
class symptoms extends StatelessWidget {
  const symptoms({Key key}) : super(key: key);

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
                            'assets/fever.png',
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
                            'Fever',
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
                      color: Colors.redAccent),
                ),
                Container(
                  child: ResponsiveRow(
                    children: [
                      FlexWidget(
                        child: Container(
                          child: Image.asset(
                            'assets/breathe.png',
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
                            'Running Nose',
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
                      color: Colors.redAccent),
                ),
                Container(
                  child: ResponsiveRow(
                    children: [
                      FlexWidget(
                        child: Container(
                          child: Image.asset(
                            'assets/cough.png',
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
                            'Cough',
                            style: GoogleFonts.oswald(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          padding: EdgeInsets.fromLTRB(20, 35, 0, 35),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                      color: Colors.redAccent),
                ),
                Container(
                  child: ResponsiveRow(
                    children: [
                      FlexWidget(
                        child: Container(
                          child: Image.asset(
                            'assets/sore.png',
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
                            'Sore trought',
                            style: GoogleFonts.oswald(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          padding: EdgeInsets.fromLTRB(20, 35, 0, 35),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                      color: Colors.redAccent),
                ),
                Container(
                  child: ResponsiveRow(
                    children: [
                      FlexWidget(
                        child: Container(
                          child: Image.asset(
                            'assets/headache.png',
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
                            'Headache',
                            style: GoogleFonts.oswald(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                          padding: EdgeInsets.fromLTRB(20, 35, 0, 35),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                      color: Colors.redAccent),
                )
              ],
            ),
          ),
        ));
  }
}
