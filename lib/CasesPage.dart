import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ssh_app/homepage.dart';
import 'package:ssh_app/news.dart';
import 'package:ssh_app/options.dart';
import 'package:ssh_app/statePage.dart';
import 'package:ssh_app/worldpage.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class CasesPage extends StatefulWidget {
  CasesPage({
    Key key,
    @required this.state_names,
    @required this.district_names,
    @required this.cases,
    @required this.category,
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

  // ignore: non_constant_identifier_names
  var state_names = [],
      district_names = {},
      cases = {},
      active_cases = {},
      recovered_cases = {},
      deaths_cases = {},
      confirmed_cases = {},
      category,
      india_cases = [],
      index,
      state_codes = [],
      daily = [],
      news;

  @override
  _CasesPageState createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {
  @override
  void initState() {
    super.initState();
  }

  // ignore: non_constant_identifier_names
  _navigate_to_page(value) {
    if (widget.index != value) {
      if (value == 0) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
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
                    )));
      }
      if (value == 2) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
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
                    )));
      } else if (value == 3) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
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
                    )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Color.fromRGBO(22, 22, 37, 1),
            backgroundColor: Color.fromRGBO(22, 22, 37, 1)),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Covid-19 Tracker"),
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: new BubbleTabIndicator(
                  indicatorHeight: 40.0,
                  indicatorColor: Color.fromRGBO(67, 107, 149, 0.5),
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                indicatorColor: Color.fromRGBO(21, 29, 51, 1),
                labelStyle: GoogleFonts.oswald(fontSize: 18),
                labelColor: Colors.blue[400],
                tabs: [
                  Tab(text: "India"),
                  Tab(
                    text: "World",
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                StatePage(
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
                ),
                WorldPage()
              ],
            ),
            bottomNavigationBar: BottomNavyBar(
              //backgroundColor: Color.fromRGBO(22, 22, 37, 1),
              backgroundColor: Colors.black,
              selectedIndex: widget.index,
              showElevation: true,
              animationDuration: Duration(milliseconds: 800),
              onItemSelected: (value) {
                _navigate_to_page(value);
              },
              items: [
                BottomNavyBarItem(
                    icon: Icon(UniconsLine.home), title: Text('Home')),
                BottomNavyBarItem(
                    icon: Icon(UniconsLine.map_pin),
                    title: Text("India Report")),
                BottomNavyBarItem(
                    icon: Icon(UniconsLine.newspaper), title: Text("News")),
                BottomNavyBarItem(
                    icon: Icon(UniconsLine.ellipsis_h), title: Text("Others"))
              ],
            ),
          ),
        ));
  }
}
