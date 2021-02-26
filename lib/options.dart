import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive/responsive_row.dart';
import 'package:ssh_app/CasesPage.dart';
import 'package:ssh_app/homepage.dart';
import 'package:ssh_app/news.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class OptionsPage extends StatefulWidget{

  // ignore: non_constant_identifier_names
  var state_names=[],district_names={},active_cases={},recovered_cases={},deaths_cases={},confirmed_cases={},india_cases=[],index,state_codes=[],daily=[],news;

  OptionsPage({
    Key key,
    // ignore: non_constant_identifier_names
    @required this.state_names,
    @required this.district_names,
    @required this.india_cases,
    @required this.active_cases,
    @required this.recovered_cases,
    @required this.deaths_cases,
    @required this.confirmed_cases,
    @required this.index,
    @required this.state_codes,
    @required this.daily,
    @required this.news,
  }) : super(key: key);

  @override
  _OptionsPage createState() => _OptionsPage();
}

class _OptionsPage extends State<OptionsPage>{
  // ignore: non_constant_identifier_names
  _navigate_to_page(value){
    if(widget.index!=value){
      if(value==0){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage(
            state_codes: widget.state_codes,
            state_names: widget.state_names,
            district_names: widget.district_names,
            india_cases: widget.india_cases,
            confirmed_cases: widget.confirmed_cases,
            active_cases: widget.active_cases,
            recovered_cases: widget.recovered_cases,
            deaths_cases: widget.deaths_cases,
            index: 0,
            daily: widget.daily,
            news: widget.news,
          )
        ));
      }
      if(value==1){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => CasesPage(
            state_codes: widget.state_codes,
            state_names: widget.state_names,
            district_names: widget.district_names,
            india_cases: widget.india_cases,
            confirmed_cases: widget.confirmed_cases,
            active_cases: widget.active_cases,
            recovered_cases: widget.recovered_cases,
            deaths_cases: widget.deaths_cases,
            cases: widget.confirmed_cases,
            category: "Confirmed",
            index: 1,
            daily: widget.daily,
            news: widget.news,
          )
        ));
      }
      if(value==2){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => NewsPage(
            state_codes: widget.state_codes,
            state_names: widget.state_names,
            district_names: widget.district_names,
            india_cases: widget.india_cases,
            confirmed_cases: widget.confirmed_cases,
            active_cases: widget.active_cases,
            recovered_cases: widget.recovered_cases,
            deaths_cases: widget.deaths_cases,
            index: 2,
            daily: widget.daily,
            news: widget.news,
          )
          ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(22, 22, 37, 1),
        scaffoldBackgroundColor: Color.fromRGBO(22, 22, 37, 1)
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Covid-19 Tracker"),
        ),
        body: ResponsiveRow(
          children: [
            Container(
                child: Text("Symptoms",style: GoogleFonts.oswald(fontSize: 21,fontWeight: FontWeight.w500,color: Colors.white)),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Row(
                  children: [
                    Container(
                      child:Center(
                        child:Column(
                          children:[
                            Container(
                            child:Image.asset('assets/cough.png',width: 60,height: 60,),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            ),
                            Text("Dry Cough",style: GoogleFonts.oswald(fontSize: 14,color: Colors.white))
                          ]
                        )
                      ),
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(51,19,39,1),
                      ),
                      height: 135,
                    ),
                    Container(
                      child:Center(
                        child:Column(
                          children:[
                            Container(
                            child:Image.asset('assets/breathe.png',width: 60,height: 60,),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            ),
                            Text("Breathing trouble",style: GoogleFonts.oswald(fontSize: 14,color: Colors.white))
                          ]
                        )
                      ),
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(51,19,39,1),
                      ),
                      height: 135,
                    ),
                    Container(
                      child:Center(
                        child:Column(
                          children:[
                            Container(
                            child:Image.asset('assets/fever.png',width: 60,height: 60,),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            ),
                            Text("Fever",style: GoogleFonts.oswald(fontSize: 14,color: Colors.white))
                          ]
                        )
                      ),
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(51,19,39,1),
                      ),
                      height: 135,
                    ),
                    Container(
                      child:Center(
                        child:Column(
                          children:[
                            Container(
                            child:Image.asset('assets/headache.png',width: 60,height: 60,),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            ),
                            Text("Headache",style: GoogleFonts.oswald(fontSize: 14,color: Colors.white))
                          ]
                        )
                      ),
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(51,19,39,1),
                      ),
                      height: 135,
                    ),
                    Container(
                      child:Center(
                        child:Column(
                          children:[
                            Container(
                            child:Image.asset('assets/sore.png',width: 60,height: 60,),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            ),
                            Text("Sore Throat",style: GoogleFonts.oswald(fontSize: 14,color: Colors.white))
                          ]
                        )
                      ),
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(51,19,39,1),
                      ),
                      height: 135,
                    ),
                    
                  ],
                )
              ),
              Container(
                child: Text("Prevention",style: GoogleFonts.oswald(fontSize: 21,fontWeight: FontWeight.w500,color: Colors.white)),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Row(
                  children: [
                    Container(
                      child:Center(
                        child:Column(
                          children:[
                            Container(
                            child:Image.asset('assets/mask.png',width: 60,height: 60,),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            ),
                            Text("Wear Mask",style: GoogleFonts.oswald(fontSize: 14,color: Colors.white))
                          ]
                        )
                      ),
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(24,40,40,1)
                      ),
                      height: 135,
                    ),
                    Container(
                      child:Center(
                        child:Column(
                          children:[
                            Container(
                            child:Image.asset('assets/distance.png',width: 60,height: 60,),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            ),
                            Text("Maintain Distance",style: GoogleFonts.oswald(fontSize: 14,color: Colors.white))
                          ]
                        )
                      ),
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(24,40,40,1),
                      ),
                      height: 135,
                    ),
                    Container(
                      child:Center(
                        child:Column(
                          children:[
                            Container(
                            child:Image.asset('assets/hands.png',width: 60,height: 60,),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            ),
                            Text("Wash Hands",style: GoogleFonts.oswald(fontSize: 14,color: Colors.white))
                          ]
                        )
                      ),
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(24,40,40,1),
                      ),
                      height: 135,
                    ),
                    Container(
                      child:Center(
                        child:Column(
                          children:[
                            Container(
                            child:Image.asset('assets/home.png',width: 60,height: 60,),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            ),
                            Text("Stay Home",style: GoogleFonts.oswald(fontSize: 14,color: Colors.white))
                          ]
                        )
                      ),
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(24,40,40,1),
                      ),
                      height: 135,
                    ),
                    Container(
                      child:Center(
                        child:Column(
                          children:[
                            Container(
                            child:Image.asset('assets/doctor.png',width: 60,height: 60,),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            ),
                          Text("Consult Doctor\n    Frequently",style: GoogleFonts.oswald(fontSize: 11,color: Colors.white))
                          ]
                        )
                      ),
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color.fromRGBO(24,40,40,1),
                      ),
                      height: 135,
                    ),

                  ],
                )
              )
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Color.fromRGBO(22, 22, 37, 1),
          selectedIndex: widget.index,
          showElevation: true,
          animationDuration: Duration(milliseconds: 800),
          onItemSelected: (value) {
            _navigate_to_page(value);
          },
          items: [
            BottomNavyBarItem(
              icon: Icon(UniconsLine.home),
              title: Text('Home')
            ),
            BottomNavyBarItem(
              icon: Icon(UniconsLine.map_pin),
              title: Text("India Report")
            ),
            BottomNavyBarItem(
              icon: Icon(UniconsLine.newspaper),
              title: Text("News")
            ),
            BottomNavyBarItem(
              icon: Icon(UniconsLine.ellipsis_h),
              title: Text("Others")
            )
          ],
        ),
      )
    );
  }
}