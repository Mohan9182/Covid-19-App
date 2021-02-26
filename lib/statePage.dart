import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:ssh_app/color.dart';
import 'package:ssh_app/model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive/responsive.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'district.dart';
import 'package:flutter_icons/flutter_icons.dart';

// ignore: must_be_immutable
class StatePage extends StatefulWidget {
  StatePage({
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
      daily = [];

  @override
  _StatePage createState() => _StatePage();
}

// ignore: must_be_immutable
class _StatePage extends State<StatePage> {
  List<Color> color;
  List<BarData> daily;
  Map<String, List<ChartData>> states = {
    "Confirmed": [],
    "Active": [],
    "Recovered": [],
    "Deceased": []
  };
  List<ChartData> data;

  // ignore: non_constant_identifier_names
  final get_color = set_color();

  var min = DateTime.now().subtract((Duration(days: 8))),
      max = DateTime.now().subtract((Duration(days: 1)));
  // ignore: non_constant_identifier_names
  var ranges = [], selectedindex = 0, activecolor, durationindex = 0;

  var f = NumberFormat('##,##,##,##,##,###');

  var _zoomPanBehavior = MapZoomPanBehavior();

  @override
  void initState() {
    setState(() {
      widget.confirmed_cases.forEach((key, value) {
        states["Confirmed"].add(ChartData(
            (key.toString().length <= 15)
                ? key
                : key.toString().substring(0, 15),
            value,
            set_color.get_color(value, "Confirmed")));
      });
      widget.active_cases.forEach((key, value) {
        states["Active"].add(ChartData(
            (key.toString().length <= 15)
                ? key
                : key.toString().substring(0, 15),
            value,
            set_color.get_color(value, "Active")));
      });
      widget.recovered_cases.forEach((key, value) {
        states["Recovered"].add(ChartData(
            (key.toString().length <= 15)
                ? key
                : key.toString().substring(0, 15),
            value,
            set_color.get_color(value, "Recovered")));
      });
      widget.deaths_cases.forEach((key, value) {
        states["Deceased"].add(ChartData(
            (key.toString().length <= 15)
                ? key
                : key.toString().substring(0, 15),
            value,
            set_color.get_color(value, "Deaceased")));
      });
    });

    _set_category();
    super.initState();
  }

  Color _get_background_color() {
    return (this.selectedindex == 0)
        ? Color.fromRGBO(77, 17, 41, 1)
        : (this.selectedindex == 1)
            ? Color.fromRGBO(21, 29, 51, 1)
            : (this.selectedindex == 2)
                ? Color.fromRGBO(24, 40, 40, 1)
                : Color.fromRGBO(28, 28, 43, 1);
  }

  // ignore: non_constant_identifier_names
  _set_category() {
    if (widget.category == "Confirmed") {
      setState(() {
        this.ranges = ["<=10K", "10K-150K", "150K-300K", ">300K"];
        this.color = [
          Colors.red[200],
          Colors.red[400],
          Colors.red[600],
          Colors.red[800]
        ];
        this.selectedindex = 0;
        this.activecolor = Colors.red;
        data = states["Confirmed"];
      });
    } else if (widget.category == "Active") {
      setState(() {
        this.ranges = ["<=5K", "5K-15K", "15K-40K", ">40K"];
        this.color = [
          Colors.blue[200],
          Colors.blue[400],
          Colors.blue[600],
          Colors.blue[800]
        ];
        this.selectedindex = 1;
        this.activecolor = Colors.blue;
        data = states["Active"];
      });
    } else if (widget.category == "Recovered") {
      setState(() {
        this.ranges = ["<=10K", "10K-150K", "150K-300K", ">300K"];
        this.color = [
          Colors.green[200],
          Colors.green[400],
          Colors.green[600],
          Colors.green[800]
        ];
        this.selectedindex = 2;
        this.activecolor = Colors.green;
        data = states["Recovered"];
      });
    } else {
      setState(() {
        this.ranges = ["<=1K", "1K-5K", "5K-15K", ">15K"];
        this.color = [
          Colors.grey[200],
          Colors.grey[400],
          Colors.grey[600],
          Colors.grey[800]
        ];
        this.selectedindex = 3;
        this.activecolor = Colors.grey;
        data = states["Deceased"];
      });
    }
  }

  _selectcategory(categorycontext) {
    Alert(
        context: categorycontext,
        style: AlertStyle(
          backgroundColor: Color.fromRGBO(22, 22, 37, 1),
          titleStyle: GoogleFonts.oswald(fontSize: 19, color: activecolor),
          overlayColor: Colors.black54,
          alertBorder: Border.all(
              color: Colors.transparent, width: 0, style: BorderStyle.none),
        ),
        title: 'Select period',
        buttons: [
          DialogButton(
            child: Row(children: [
              Container(
                child: Icon(
                  FlutterIcons.calendar_week_faw5s,
                  color: activecolor,
                ),
                margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
              ),
              Container(
                child: Text(
                  '7 Days',
                  style: GoogleFonts.oswald(fontSize: 16, color: activecolor),
                ),
              )
            ]),
            radius: BorderRadius.circular(15),
            color: _get_background_color(),
            onPressed: () {
              setState(() {
                this.min = DateTime.now().subtract((Duration(days: 8)));
                this.max = DateTime.now().subtract((Duration(days: 1)));
              });
              Navigator.of(context, rootNavigator: true).pop();
              ;
              _linechart();
            },
          ),
          DialogButton(
            child: Row(children: [
              Container(
                child: Icon(
                  FlutterIcons.calendar_alt_faw5,
                  color: activecolor,
                ),
                margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
              ),
              Container(
                child: Text(
                  '30 Days',
                  style: GoogleFonts.oswald(fontSize: 16, color: activecolor),
                ),
              )
            ]),
            radius: BorderRadius.circular(15),
            color: _get_background_color(),
            onPressed: () {
              setState(() {
                this.min = DateTime.now().subtract((Duration(days: 31)));
                this.max = DateTime.now().subtract((Duration(days: 1)));
              });
              Navigator.of(context, rootNavigator: true).pop();
              _linechart();
            },
          ),
        ]).show();
  }

  _linechart() async {
    final result = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
          minHeight: 420,
          elevation: 8,
          cornerRadius: 25,
          color: Color.fromRGBO(22, 22, 37, 1),
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.8, 0.9, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return Material(
                type: MaterialType.transparency,
                child: Container(
                  child: Column(children: [
                    Container(
                      child: IconButton(
                        icon: Icon(
                          FontAwesome.close,
                          color: Colors.white60,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    Container(
                      child: SfCartesianChart(
                          enableAxisAnimation: true,
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                          ),
                          plotAreaBorderWidth: 0,
                          primaryXAxis: DateTimeAxis(
                              majorGridLines: MajorGridLines(
                                width: 0,
                              ),
                              labelRotation: 60,
                              labelStyle: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: 13),
                              minimum: min,
                              maximum: max),
                          primaryYAxis: NumericAxis(
                              majorGridLines: MajorGridLines(width: 0),
                              labelFormat: '{value}K',
                              labelStyle: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: 13)),
                          borderWidth: 0,
                          zoomPanBehavior:
                              ZoomPanBehavior(enablePinching: true),
                          // title: ChartTitle(
                          //   text: "Daily Report",
                          //   textStyle: GoogleFonts.oswald(color: Colors.white,fontSize: 20)
                          // ),
                          //backgroundColor: Color.fromRGBO(77,17,41,1),
                          series: <ChartSeries>[
                            LineSeries<BarData, DateTime>(
                                opacity: 1,
                                enableTooltip: true,
                                dataSource: widget.daily[this.selectedindex],
                                pointColorMapper: (BarData bar, _) =>
                                    activecolor,
                                xValueMapper: (BarData bar, _) => bar.x,
                                yValueMapper: (BarData bar, _) => bar.y / 1000,
                                markerSettings: MarkerSettings(
                                    isVisible: true, color: this.activecolor),
                                animationDuration: 1,
                                color: (widget.category == 'Confirmed')
                                    ? Colors.red[400]
                                    : (widget.category == 'Active')
                                        ? Colors.blue[400]
                                        : (widget.category == 'Recovered')
                                            ? Colors.green[400]
                                            : Colors.grey[400]),
                          ]),
                      height: 340,
                    ),
                  ]),
                  height: 400,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                ));
          });
    });
    print(result);
  }

  _barchart() async {
    final result = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
          minHeight: 420,
          elevation: 8,
          cornerRadius: 16,
          color: Color.fromRGBO(22, 22, 37, 1),
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.8, 0.9, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return Material(
                type: MaterialType.transparency,
                child: Container(
                  child: Column(children: [
                    Container(
                      child: IconButton(
                        icon: Icon(
                          FontAwesome.close,
                          color: Colors.white60,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    Container(
                      child: SfCartesianChart(
                          enableAxisAnimation: true,
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                          ),
                          plotAreaBorderWidth: 0,
                          primaryXAxis: CategoryAxis(
                            majorGridLines: MajorGridLines(
                              width: 0,
                            ),
                            labelRotation: 60,
                            labelStyle: GoogleFonts.oswald(
                                color: Colors.white, fontSize: 13),
                          ),
                          primaryYAxis: NumericAxis(
                            majorGridLines: MajorGridLines(width: 0),
                            // labelFormat: '{value}K',
                            // labelStyle: GoogleFonts.oswald(color:Colors.white,fontSize: 13)
                          ),
                          borderWidth: 0,
                          zoomPanBehavior:
                              ZoomPanBehavior(enablePinching: true),
                          series: <CartesianSeries>[
                            ColumnSeries<ChartData, String>(
                              dataSource: data,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              //dataLabelMapper: (ChartData data, _) => data.x,
                              // enableSmartLabels: true,
                              // explode: true,
                            )
                          ]),
                      height: 340,
                    )
                  ]),
                  height: 400,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                ));
          });
    });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      color: Color.fromRGBO(22, 22, 37, 1),
      child: Column(children: [
        Container(
            child: GNav(
              gap: 8,
              selectedIndex: this.selectedindex,
              activeColor: this.activecolor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              iconSize: 20,
              tabs: [
                GButton(
                  icon: FlutterIcons.ambulance_faw,
                  text: "Confirmed",
                  iconColor: Colors.red,
                  backgroundColor: Color.fromRGBO(77, 17, 41, 1),
                  active: true,
                  iconSize: 20,
                ),
                GButton(
                  icon: FlutterIcons.syringe_faw5s,
                  text: "Active",
                  iconColor: Colors.blue,
                  backgroundColor: Color.fromRGBO(21, 29, 51, 1),
                  active: true,
                  iconSize: 20,
                ),
                GButton(
                  icon: FlutterIcons.redo_faw5s,
                  text: "Recovered",
                  iconColor: Colors.green,
                  backgroundColor: Color.fromRGBO(24, 40, 40, 1),
                  active: true,
                  iconSize: 20,
                ),
                GButton(
                  icon: FlutterIcons.heart_broken_faw5s,
                  text: "Deaths",
                  iconColor: Colors.grey,
                  backgroundColor: Color.fromRGBO(28, 28, 43, 1),
                  active: true,
                  iconSize: 20,
                )
              ],
              onTabChange: (index) {
                //_changePage(context, index);
                if (index != this.selectedindex) {
                  if (index == 0) {
                    setState(() {
                      widget.cases = widget.confirmed_cases;
                      widget.category = "Confirmed";
                    });
                  } else if (index == 1) {
                    setState(() {
                      widget.cases = widget.active_cases;
                      widget.category = "Active";
                    });
                  } else if (index == 2) {
                    setState(() {
                      widget.cases = widget.recovered_cases;
                      widget.category = "Recovered";
                    });
                  } else {
                    setState(() {
                      widget.cases = widget.deaths_cases;
                      widget.category = "Deceased";
                    });
                  }
                  _set_category();
                }
              },
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            margin: EdgeInsets.fromLTRB(5, 15, 5, 5)),
        Container(
          child: SfMaps(
            layers: [
              MapShapeLayer(
                source: MapShapeSource.asset(
                  'assets/india.json',
                  shapeDataField: "ST_NM",
                  dataCount: widget.cases.length,
                  primaryValueMapper: (index) {
                    return widget.state_names[index];
                  },
                  shapeColorValueMapper: (index) {
                    return set_color.get_color(
                        widget.cases[widget.state_names[index]],
                        widget.category);
                  },
                ),
                // ignore: missing_return
                shapeTooltipBuilder: (context, index) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => District(
                                name: widget.state_names[index],
                                district_names: widget
                                    .district_names[widget.state_names[index]],
                                category: widget.category,
                                state_cases:
                                    widget.cases[widget.state_names[index]],
                                state_codes: widget.state_codes,
                                index: index,
                              )));
                },
                zoomPanBehavior: _zoomPanBehavior,
                strokeColor: Colors.black26,
              ),
            ],
          ),
          height: 550,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        ),
        ResponsiveRow(columnsCount: 12, children: [
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
                xs: 3,
                sm: 4,
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
                  xs: 3,
                  sm: 4,
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
                  xs: 3,
                  sm: 4,
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
                xs: 3,
                sm: 4,
                md: 4,
                lg: 4,
              ),
            ]),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
          )
        ]),
        Container(
          child: ResponsiveRow(
            columnsCount: 13,
            spacing: 10,
            children: [
              FlexWidget(
                child: Container(
                  child: Container(
                    child: FlatButton.icon(
                      icon: Icon(
                        FlutterIcons.line_chart_faw,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Daily Reports',
                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      color: _get_background_color(),
                      onPressed: () => _selectcategory(context),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: _get_background_color()),
                  height: 75,
                ),
                xs: 6,
                md: 6,
                xl: 6,
                lg: 6,
              ),
              FlexWidget(
                child: Container(
                  child: Container(
                    child: FlatButton.icon(
                      icon: Icon(
                        FlutterIcons.bar_chart_faw,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Districts Graph',
                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      color: _get_background_color(),
                      onPressed: () => _barchart(),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: _get_background_color()),
                  height: 75,
                ),
                xs: 6,
                md: 6,
                xl: 6,
                lg: 6,
              ),
            ],
          ),
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        ),
        DataTable(
          columns: [
            DataColumn(
                label: Text("Index",
                    style: GoogleFonts.oswald(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text("State",
                    style: GoogleFonts.oswald(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text(widget.category,
                    style: GoogleFonts.oswald(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
          ],
          rows: widget.cases.keys
              .toList()
              .reversed
              .toList()
              .map((element) => DataRow(cells: [
                    DataCell(Text(
                        (widget.cases.keys
                                    .toList()
                                    .reversed
                                    .toList()
                                    .indexOf(element) +
                                1)
                            .toString(),
                        style: GoogleFonts.oswald(
                            fontSize: 15, color: Colors.white))),
                    DataCell(Text(element,
                        style: GoogleFonts.oswald(
                            fontSize: 15, color: Colors.white))),
                    DataCell(Text(f.format(widget.cases[element]).toString(),
                        style: GoogleFonts.oswald(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)))
                  ]))
              .toList(),
          columnSpacing: 33,
          sortColumnIndex: 1,
        )
      ]),
    ));
  }
}
