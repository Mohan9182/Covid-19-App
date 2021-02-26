import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:responsive/flex_widget.dart';
import 'package:responsive/responsive_row.dart';
import 'package:ssh_app/CasesPage.dart';
import 'package:ssh_app/homepage.dart';
import 'package:ssh_app/inappnews.dart';
import 'package:ssh_app/options.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class NewsPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  var state_names = [],
      district_names = {},
      active_cases = {},
      recovered_cases = {},
      deaths_cases = {},
      confirmed_cases = {},
      india_cases = [],
      index,
      state_codes = [],
      daily = [],
      news;

  // ignore: non_constant_identifier_names
  NewsPage({
    Key key,
    @required this.state_codes,
    @required this.state_names,
    @required this.district_names,
    @required this.india_cases,
    @required this.confirmed_cases,
    @required this.active_cases,
    @required this.recovered_cases,
    @required this.deaths_cases,
    @required this.daily,
    @required this.index,
    @required this.news,
  }) : super(key: key);

  @override
  _NewsPage createState() => _NewsPage();
}

class _NewsPage extends State<NewsPage> {
  // ignore: non_constant_identifier_names
  List<Widget> widget_list = [];

  var selectedindex = 0, color, text_color, cases = {}, category;

  @override
  void initState() {
    widget.news.forEach((n) {
      setState(() {
        widget_list.add(_make_widget(n["media"], n["title"], n["link"]));
      });
    });
    super.initState();
  }

  // ignore: non_constant_identifier_names
  _make_widget(imageUrl, title, link) {
    return InkWell(
      child: Container(
        child: Column(children: [
          ResponsiveRow(children: [
            FlexWidget(
              child: Container(
                height: 175,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(25)),
              ),
              xs: 12,
              md: 12,
              lg: 12,
              xl: 12,
            ),
            FlexWidget(
              child: Container(
                child: Text(
                  title,
                  style: GoogleFonts.oswald(fontSize: 16, color: Colors.white),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff161625),
                ),
              ),
              xs: 12,
              md: 12,
              lg: 12,
              xl: 12,
            )
          ]),
        ]),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35), color: Color(0xff161625)),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        margin: EdgeInsets.all(5),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InAppViewNews(
                      link: link,
                    )));
      },
    );
  }

  _navigate_to_page(value) {
    if (widget.index != value) {
      if (value == 1) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
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
                    )));
      } else if (value == 0) {
        Navigator.push(
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
        scaffoldBackgroundColor: Color.fromRGBO(22, 22, 37, 1),
        primaryColor: Color.fromRGBO(22, 22, 37, 1),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Covid-19 Tracker"),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Column(children: this.widget_list.map((e) => e).toList()),
        ])),
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
                icon: Icon(UniconsLine.home), title: Text('Home')),
            BottomNavyBarItem(
                icon: Icon(UniconsLine.map_pin), title: Text("India Report")),
            BottomNavyBarItem(
                icon: Icon(UniconsLine.newspaper), title: Text("News")),
            BottomNavyBarItem(
                icon: Icon(UniconsLine.ellipsis_h), title: Text("Others"))
          ],
        ),
      ),
    );
  }
}
