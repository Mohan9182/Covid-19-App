import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive/flex_widget.dart';
import 'package:responsive/responsive_row.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:sortedmap/sortedmap.dart';
import 'package:ssh_app/CasesPage.dart';
import 'package:ssh_app/model.dart';
import 'package:ssh_app/options.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ssh_app/news.dart';
import 'package:unicons/unicons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget{

  // ignore: non_constant_identifier_names
  var state_names=[],state_codes=[],district_names={},india_cases=[],confirmed_cases={},active_cases={},recovered_cases={},deaths_cases={},daily=[],index,news;

  // ignore: non_constant_identifier_names
  HomePage({ Key key,
  @required this.state_names,
  @required this.state_codes,
  @required this.district_names,
  @required this.confirmed_cases,
  @required this.india_cases,
  @required this.active_cases,
  @required this.recovered_cases,
  @required this.deaths_cases,
  @required this.index,
  @required this.daily,
  @required this.news,
  }) : super(key: key);

  @override
  _Homepage createState() => _Homepage();
}

class _Homepage extends State<HomePage>{
  // ignore: non_constant_identifier_names
  var india_cases=[];

  List<PieData> chartData=[];
  // ignore: non_constant_identifier_names
  var confirmed_cases=SortedMap(Ordering.byValue()),active_cases=SortedMap(Ordering.byValue()),recovered_cases=SortedMap(Ordering.byValue()),deaths_cases=SortedMap(Ordering.byValue());

  var f = NumberFormat('##,##,##,##,##,###');

  @override
  void initState(){
    if(widget.india_cases.isEmpty){
    _get_state_data().then((jsonResponse){
      setState(() {
        this.india_cases.addAll([jsonResponse["TT"]["total"]["confirmed"],jsonResponse["TT"]["total"]["deceased"],jsonResponse["TT"]["total"]["recovered"],jsonResponse["TT"]["total"]["confirmed"]-jsonResponse["TT"]["total"]["deceased"]-jsonResponse["TT"]["total"]["recovered"]]);
      });
      widget.state_codes.forEach((element){
      var state = jsonResponse[element];
      if(state!=null){
        var confirmed = state["total"]["confirmed"];
        var active = state["total"]["confirmed"]-state["total"]["deceased"]-state["total"]["recovered"];
        var recovered = state["total"]["recovered"];
        var deaths = state["total"]["deceased"];
        setState(() {
          this.confirmed_cases.addAll({widget.state_names[widget.state_codes.indexOf(element)]:confirmed});
          this.active_cases.addAll({widget.state_names[widget.state_codes.indexOf(element)]:active});
          this.recovered_cases.addAll({widget.state_names[widget.state_codes.indexOf(element)]:recovered});
          this.deaths_cases.addAll({widget.state_names[widget.state_codes.indexOf(element)]:deaths});
        });
      }
    });
    });
    }
    else{
      this.india_cases = widget.india_cases;
      this.confirmed_cases = widget.confirmed_cases;
      this.active_cases = widget.active_cases;
      this.recovered_cases = widget.recovered_cases;
      this.deaths_cases = widget.deaths_cases;
    }
    _get_state_data().then((jsonResponse){
      setState(() {
        this.chartData.addAll([PieData('Active',((jsonResponse["TT"]["total"]["confirmed"]-jsonResponse["TT"]["total"]["deceased"]-jsonResponse["TT"]["total"]["recovered"])/jsonResponse["TT"]["total"]["confirmed"])*100,Colors.lightBlue),PieData('Recovered',(jsonResponse["TT"]["total"]["recovered"]/jsonResponse["TT"]["total"]["confirmed"])*100,Colors.green[400]),PieData('Deaths',(jsonResponse["TT"]["total"]["deceased"]/jsonResponse["TT"]["total"]["confirmed"])*100,Colors.grey)]);
      });
    });
    super.initState();
  }

  // ignore: non_constant_identifier_names
  _navigate_to_page(value){
    if(widget.index!=value){
      if(value==1){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => CasesPage(
            state_codes: widget.state_codes,
            state_names: widget.state_names,
            district_names: widget.district_names,
            india_cases: this.india_cases,
            confirmed_cases: this.confirmed_cases,
            active_cases: this.active_cases,
            recovered_cases: this.recovered_cases,
            deaths_cases: this.deaths_cases,
            cases: this.confirmed_cases,
            category: "Confirmed",
            index: 1,
            daily: widget.daily,
            news: widget.news,
          )
        ));
      }
      else if(value==2){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => NewsPage(
            state_codes: widget.state_codes,
            state_names: widget.state_names,
            district_names: widget.district_names,
            india_cases: this.india_cases,
            confirmed_cases: this.confirmed_cases,
            active_cases: this.active_cases,
            recovered_cases: this.recovered_cases,
            deaths_cases: this.deaths_cases,
            index: 2,
            daily: widget.daily,
            news: widget.news,
          )
        ));
      }
      else if(value==3){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => OptionsPage(
            state_codes: widget.state_codes,
            state_names: widget.state_names,
            district_names: widget.district_names,
            india_cases: widget.india_cases,
            confirmed_cases: widget.confirmed_cases,
            active_cases: widget.active_cases,
            recovered_cases: widget.recovered_cases,
            deaths_cases: widget.deaths_cases,
            index: 3,
            daily: widget.daily,
            news: widget.news,
          )
        ));
      }
    }
  }

  // ignore: non_constant_identifier_names
  _get_state_data() async{
    var response = await http.get('https://api.covid19india.org/v4/data.json');
    return convert.jsonDecode(response.body);
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
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text("India Cases",style: GoogleFonts.oswald(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.white70),textAlign: TextAlign.center,),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                width: 500,
              ),
              ResponsiveRow(
                children: [
                  FlexWidget(
                    child: Container(
                      child: Row(
                        children:[
                          Container(
                            child:Center(
                              child: Icon(UniconsLine.ambulance,color: Colors.red),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          Container(
                            child:Center(
                              child:Text("Confirmed \n "+f.format(this.india_cases[0]).toString(),style: GoogleFonts.oswald(color: Colors.red,fontSize: 16)),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                          )
                        ]
                      ),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        ),
                        color: Color.fromRGBO(77,17,41,1),
                      ),
                      height: 90,
                    ),
                    xs: 6,
                    sm: 6,
                    md: 6,
                    lg: 6,
                  ),
                  FlexWidget(
                    child: Container(
                      child: Row(
                        children:[
                          Container(
                            child:Center(
                              child: Icon(UniconsLine.redo,color: Colors.green),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          Container(
                            child:Center(
                              child:Text("Recovered \n "+f.format(india_cases[2]).toString(),style: GoogleFonts.oswald(color: Colors.green,fontSize: 16)),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                          )
                        ]
                      ),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        ),
                        color: Color.fromRGBO(24,40,40,1),
                      ),
                      height: 90,
                    ),
                    xs: 6,
                    sm: 6,
                    md: 6,
                    lg: 6,
                  ),
                  FlexWidget(
                    child: Container(
                      child: Row(
                        children:[
                          Container(
                            child:Center(
                              child: Icon(UniconsLine.syringe,color: Colors.blue),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          Container(
                            child:Center(
                              child:Text("  Active \n "+f.format(this.india_cases[3]).toString(),style: GoogleFonts.oswald(color: Colors.blue,fontSize: 16)),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                          )
                        ]
                      ),
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          ),
                          color: Color.fromRGBO(21, 29, 51, 1),
                        ),
                        height: 90,
                    ),
                    xs: 6,
                    sm: 6,
                    md: 6,
                    lg: 6,
                  ),
                  FlexWidget(
                    child: Container(
                      child: Row(
                        children:[
                          Container(
                            child:Center(
                              child: Icon(UniconsLine.heart_break,color: Colors.grey),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          ),
                          Container(
                            child:Center(
                              child:Text("  Deaths \n "+f.format(india_cases[1]).toString(),style: GoogleFonts.oswald(color: Colors.grey,fontSize: 16)),
                            ),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                          )
                        ]
                      ),
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          ),
                          color: Color.fromRGBO(28, 28, 43, 1),
                        ),
                        height: 90,
                    ),
                    xs: 6,
                    sm: 6,
                    md: 6,
                    lg: 6,
                  )
                ],
              ),
              Container(
                child: SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    legendItemBuilder: (String name, dynamic series, dynamic point, int index){
                      return Container(
                        child:Text(point.x+'-'+point.y.toStringAsFixed(2)+'%',style: GoogleFonts.oswald(color: point.color,fontSize: 13),textAlign: TextAlign.center,),
                        width: 120,
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      );
                    },
                    position: LegendPosition.bottom,
                    width: '500',
                    //height: '500'
                    ),
                  series: <CircularSeries>[
                    PieSeries<PieData, String>(
                      dataSource: chartData,
                      pointColorMapper:(PieData data,  _) => data.color,
                      xValueMapper: (PieData data, _) => data.x,
                      yValueMapper: (PieData data, _) => data.y,
                      radius: '120',
                      enableSmartLabels: true,
                      explode: true,
                      explodeAll: true,
                    )
                  ]
                ),
                height: 380,
                margin: EdgeInsets.all(5),
              )
            ],
          ),
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
      ),
    );
  }
}