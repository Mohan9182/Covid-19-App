import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:responsive/responsive.dart';
import 'package:unicons/unicons.dart';
import 'package:ssh_app/color.dart';

// ignore: must_be_immutable
class WorldPage extends StatefulWidget {
  WorldPage({
    Key key,
  }) : super(key: key);

  @override
  _WorldPage createState() => _WorldPage();
}

class _WorldPage extends State<WorldPage> {
  var _zoomPanBehavior = MapZoomPanBehavior();
  var world_cases = [],
      confirmed_cases = {},
      country_names = [],
      active_cases = {},
      recovered_cases = {},
      deaths_cases = {},
      cases = {},
      ranges = ["<=10K", "10K-150K", "150K-300K", ">300K"],
      color = [
        Colors.red[200],
        Colors.red[400],
        Colors.red[600],
        Colors.red[800]
      ];
  var selectedindex = 0, activecolor = Colors.red, category = "Confirmed";
  var names = {"USA": "United States of America", "UK": "United Kingdom"};
  var f = NumberFormat('##,##,##,##,##,###');

  @override
  void initState() {
    _get_world_cases().then((country) {
      setState(() {
        this.world_cases.addAll([
          country["cases"],
          country["active"],
          country["recovered"],
          country["deaths"]
        ]);
      });
    });
    _get_country_cases().then((jsonResponse) {
      jsonResponse.forEach((country) {
        if (names.containsKey(country["country"])) {
          setState(() {
            country_names.add(names[country["country"]]);
            confirmed_cases
                .addAll({names[country["country"]]: country["cases"]});
            active_cases.addAll({names[country["country"]]: country["active"]});
            recovered_cases.addAll({
              names[country["country"]]:
                  country["cases"] - country["deaths"] - country["active"]
            });
            deaths_cases.addAll({names[country["country"]]: country["deaths"]});
          });
        } else {
          setState(() {
            country_names.add(country["country"]);
            confirmed_cases.addAll({country["country"]: country["cases"]});
            active_cases.addAll({country["country"]: country["active"]});
            recovered_cases.addAll({
              country["country"]:
                  country["cases"] - country["deaths"] - country["active"]
            });
            deaths_cases.addAll({country["country"]: country["deaths"]});
          });
        }
      });
      setState(() {
        cases = confirmed_cases;
      });
    });
    super.initState();
  }

  _get_world_cases() async {
    var response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    return convert.jsonDecode(response.body);
  }

  // ignore: non_constant_identifier_names
  _get_country_cases() async {
    //var response = await http.get('https://coronavirus-19-api.herokuapp.com/countries');
    var response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries?sort=cases'));
    return convert.jsonDecode(response.body);
  }

  _set_category() {
    if (category == "Confirmed") {
      setState(() {
        this.ranges = ["<=100K", "100K-1.5M", "1.5M-3M", ">3M"];
        color = [
          Colors.red[200],
          Colors.red[400],
          Colors.red[600],
          Colors.red[800]
        ];
        this.selectedindex = 0;
        this.activecolor = Colors.red;
      });
    } else if (category == "Active") {
      setState(() {
        this.ranges = ["<=50K", "50K-150K", "150K-400K", ">400K"];
        this.color = [
          Colors.blue[200],
          Colors.blue[400],
          Colors.blue[600],
          Colors.blue[800]
        ];
        this.selectedindex = 1;
        this.activecolor = Colors.blue;
      });
    } else if (category == "Recovered") {
      setState(() {
        this.ranges = ["<=100K", "100K-1.5M", "1.5M-3M", ">3M"];
        this.color = [
          Colors.green[200],
          Colors.green[400],
          Colors.green[600],
          Colors.green[800]
        ];
        this.selectedindex = 2;
        this.activecolor = Colors.green;
      });
    } else {
      setState(() {
        this.ranges = ["<=10K", "10K-50K", "50K-150K", ">150K"];
        this.color = [
          Colors.grey[200],
          Colors.grey[400],
          Colors.grey[600],
          Colors.grey[800]
        ];
        this.selectedindex = 3;
        this.activecolor = Colors.grey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      color: Color.fromRGBO(22, 22, 37, 1),
      child: Column(children: [
        Container(
            child: Column(children: [
          Container(
            child: ResponsiveRow(
              children: [
                FlexWidget(
                  child: Container(
                    child: Row(children: [
                      Container(
                        child: Center(
                          child: Icon(UniconsLine.ambulance, color: Colors.red),
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      ),
                      Container(
                        child: Center(
                          child: Text(
                              "Confirmed \n " +
                                  f.format(world_cases[0]).toString(),
                              style: GoogleFonts.oswald(
                                  color: Colors.red, fontSize: 16)),
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                      )
                    ]),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(77, 17, 41, 1),
                    ),
                    height: 90,
                  ),
                  xs: 3,
                  sm: 3,
                  md: 6,
                  lg: 6,
                ),
                FlexWidget(
                  child: Container(
                    child: Row(children: [
                      Container(
                        child: Center(
                          child: Icon(UniconsLine.redo, color: Colors.green),
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      ),
                      Container(
                        child: Center(
                          child: Text(
                              "Recovered \n " +
                                  f.format(world_cases[2]).toString(),
                              style: GoogleFonts.oswald(
                                  color: Colors.green, fontSize: 16)),
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                      )
                    ]),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(24, 40, 40, 1),
                    ),
                    height: 90,
                  ),
                  xs: 3,
                  sm: 3,
                  md: 6,
                  lg: 6,
                ),
                FlexWidget(
                  child: Container(
                    child: Row(children: [
                      Container(
                        child: Center(
                          child: Icon(UniconsLine.syringe, color: Colors.blue),
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      ),
                      Container(
                        child: Center(
                          child: Text(
                              "  Active \n " +
                                  f.format(this.world_cases[1]).toString(),
                              style: GoogleFonts.oswald(
                                  color: Colors.blue, fontSize: 16)),
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                      )
                    ]),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(21, 29, 51, 1),
                    ),
                    height: 90,
                  ),
                  xs: 3,
                  sm: 3,
                  md: 6,
                  lg: 6,
                ),
                FlexWidget(
                  child: Container(
                    child: Row(children: [
                      Container(
                        child: Center(
                          child:
                              Icon(UniconsLine.heart_break, color: Colors.grey),
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      ),
                      Container(
                        child: Center(
                          child: Text(
                              "  Deaths \n " +
                                  f.format(world_cases[3]).toString(),
                              style: GoogleFonts.oswald(
                                  color: Colors.grey, fontSize: 16)),
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                      )
                    ]),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(28, 28, 43, 1),
                    ),
                    height: 90,
                  ),
                  xs: 3,
                  sm: 3,
                  md: 6,
                  lg: 6,
                )
              ],
            ),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          ),
          Container(
              child: GNav(
                gap: 8,
                selectedIndex: selectedindex,
                activeColor: activecolor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                iconSize: 24,
                tabs: [
                  GButton(
                    icon: UniconsLine.ambulance,
                    text: "Confirmed",
                    iconColor: Colors.red,
                    backgroundColor: Color.fromRGBO(77, 17, 41, 1),
                    active: true,
                  ),
                  GButton(
                    icon: UniconsLine.syringe,
                    text: "Active",
                    iconColor: Colors.blue,
                    backgroundColor: Color.fromRGBO(21, 29, 51, 1),
                  ),
                  GButton(
                    icon: UniconsLine.redo,
                    text: "Recovered",
                    iconColor: Colors.green,
                    backgroundColor: Color.fromRGBO(24, 40, 40, 1),
                  ),
                  GButton(
                    icon: UniconsLine.heart_break,
                    text: "Deaths",
                    iconColor: Colors.grey,
                    backgroundColor: Color.fromRGBO(28, 28, 43, 1),
                  )
                ],
                onTabChange: (index) {
                  //_changePage(context, index);
                  if (index != this.selectedindex) {
                    if (index == 0) {
                      setState(() {
                        cases = confirmed_cases;
                        category = "Confirmed";
                      });
                    } else if (index == 1) {
                      setState(() {
                        cases = active_cases;
                        category = "Active";
                      });
                    } else if (index == 2) {
                      setState(() {
                        cases = recovered_cases;
                        category = "Recovered";
                      });
                    } else {
                      setState(() {
                        cases = deaths_cases;
                        category = "Deceased";
                      });
                    }
                    _set_category();
                  }
                },
              ),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
              margin: EdgeInsets.fromLTRB(5, 15, 5, 5)),
          Container(
            child: SfMaps(
              layers: [
                MapShapeLayer(
                  source: MapShapeSource.asset(
                    'assets/world.json',
                    shapeDataField: "name",
                    dataCount: country_names.length,
                    primaryValueMapper: (index) {
                      return country_names[index];
                    },
                    shapeColorValueMapper: (index) {
                      return set_color.get_world_color(
                          cases[country_names[index]], category);
                    },
                  ),
                  zoomPanBehavior: _zoomPanBehavior,
                  strokeColor: Colors.black26,
                ),
              ],
            ),
            height: 300,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          ),
          ResponsiveRow(columnsCount: 16, children: [
            Container(
              child: Row(children: [
                Container(
                    child: FlexWidget(
                  child: Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.stop_circle_rounded,
                          color: this.color[0],
                          size: 20,
                        ),
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      ),
                      Container(
                          child: Text(this.ranges[0],
                              style: GoogleFonts.oswald(
                                  fontSize: 15, color: Colors.white))),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  xs: 2,
                  sm: 2,
                  md: 4,
                  lg: 4,
                )),
                Container(
                  child: FlexWidget(
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.stop_circle_rounded,
                            color: this.color[1],
                            size: 20,
                          ),
                        ),
                        Container(
                            child: Text(this.ranges[1],
                                style: GoogleFonts.oswald(
                                    fontSize: 15, color: Colors.white))),
                      ],
                    ),
                    xs: 2,
                    sm: 2,
                    md: 4,
                    lg: 4,
                  ),
                ),
                Container(
                  child: FlexWidget(
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.stop_circle_rounded,
                            color: this.color[2],
                            size: 20,
                          ),
                        ),
                        Container(
                          child: Text(this.ranges[2],
                              style: GoogleFonts.oswald(
                                  fontSize: 15, color: Colors.white)),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    xs: 2,
                    sm: 2,
                    md: 4,
                    lg: 4,
                  ),
                ),
                FlexWidget(
                  child: Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.stop_circle_rounded,
                          color: this.color[3],
                          size: 20,
                        ),
                      ),
                      Container(
                        child: Text(this.ranges[3],
                            style: GoogleFonts.oswald(
                                fontSize: 15, color: Colors.white)),
                      ),
                    ],
                  ),
                  xs: 2,
                  sm: 2,
                  md: 4,
                  lg: 4,
                ),
              ]),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            )
          ]),
          DataTable(
            columns: [
              DataColumn(
                  label: Text("Index",
                      style: GoogleFonts.oswald(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text("Country",
                      style: GoogleFonts.oswald(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text(category,
                      style: GoogleFonts.oswald(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
            ],
            rows: cases.keys
                .toList()
                .map((element) => DataRow(cells: [
                      DataCell(Text(
                          (cases.keys.toList().indexOf(element) + 1).toString(),
                          style: GoogleFonts.oswald(
                              fontSize: 15, color: Colors.white))),
                      DataCell(Text(element,
                          style: GoogleFonts.oswald(
                              fontSize: 15, color: Colors.white))),
                      DataCell(Text(f.format(cases[element]).toString(),
                          style: GoogleFonts.oswald(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)))
                    ]))
                .toList(),
            columnSpacing: 33,
            sortColumnIndex: 1,
          )
        ])),
      ]),
    ));
  }
}
