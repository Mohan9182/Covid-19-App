import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:responsive/responsive.dart';
import 'dart:convert' as convert;
import 'package:sortedmap/sortedmap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ssh_app/model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ssh_app/color.dart';
import 'package:unicons/unicons.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: must_be_immutable
class District extends StatefulWidget {
  District(
      {Key key,
      // ignore: non_constant_identifier_names
      @required this.name,
      @required this.district_names,
      @required this.category,
      @required this.state_cases,
      @required this.state_codes,
      @required this.index})
      : super(key: key);

  // ignore: non_constant_identifier_names
  var name,
      district_names = [],
      category = "",
      state_cases = 0,
      state_codes = [],
      index;

  @override
  _District createState() => _District();
}

// ignore: camel_case_types
class _District extends State<District> {
  var cases = SortedMap(Ordering.byValue());
  // ignore: non_constant_identifier_names
  var color, text_color, durationindex = 0;

  List<ChartData> data = [];
  var dates = List<DateTime>.generate(
      30, (i) => DateTime.now().subtract(Duration(days: i + 1)));
  var f = NumberFormat('##,##,##,##,##,###');
  var min = DateTime.now().subtract((Duration(days: 8))),
      max = DateTime.now().subtract((Duration(days: 1)));
  // ignore: non_constant_identifier_names
  List<BarData> state_daily = [];

  RandomColor _randomColor = RandomColor();

  @override
  void initState() {
    _get_district_cases().then((jsonResponse) {
      var district = jsonResponse[widget.name]["districtData"];
      widget.district_names.forEach((element) {
        var value = district[element][widget.category.toLowerCase()];
        setState(() {
          this.cases.addAll({element: value});
          data.add(ChartData(
              element, value, get_district_color(value, widget.category)));
        });
      });
      if (district["Unknown"][widget.category.toLowerCase()] != null) {
        setState(() {
          this.cases.addAll(
              {"Unknown": district["Unknown"][widget.category.toLowerCase()]});
          data.add(ChartData(
              "Unknown",
              district["Unknown"][widget.category.toLowerCase()],
              get_district_color(
                  district["Unknown"][widget.category.toLowerCase()],
                  widget.category)));
        });
      }
    });
    _get_daily_changes().then((jsonResponse) {
      var states = jsonResponse["states_daily"];
      if (widget.category == "Confirmed") {
        dates.forEach((d) {
          var value = (d.difference(DateTime(2020, 3, 14)).inDays) * 3;
          setState(() {
            this.state_daily.add(BarData(
                d,
                int.parse(states[value]
                    [widget.state_codes[widget.index].toLowerCase()])));
          });
        });
      } else if (widget.category == "Active") {
        dates.forEach((d) {
          var value = (d.difference(DateTime(2020, 3, 14)).inDays) * 3;
          setState(() {
            this.state_daily.add(BarData(
                d,
                int.parse(states[value]
                        [widget.state_codes[widget.index].toLowerCase()]) -
                    int.parse(states[value + 1]
                        [widget.state_codes[widget.index].toLowerCase()]) -
                    int.parse(states[value + 2]
                        [widget.state_codes[widget.index].toLowerCase()])));
          });
        });
      } else if (widget.category == "Recovered") {
        dates.forEach((d) {
          var value = (d.difference(DateTime(2020, 3, 14)).inDays) * 3;
          setState(() {
            this.state_daily.add(BarData(
                d,
                int.parse(states[value + 1]
                    [widget.state_codes[widget.index].toLowerCase()])));
          });
        });
      } else {
        dates.forEach((d) {
          var value = (d.difference(DateTime(2020, 3, 14)).inDays) * 3;
          setState(() {
            this.state_daily.add(BarData(
                d,
                int.parse(states[value + 2]
                    [widget.state_codes[widget.index].toLowerCase()])));
          });
        });
      }
    });
    _get_color();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  _get_daily_changes() async {
    var response =
        await http.get('https://api.covid19india.org/states_daily.json');
    return convert.jsonDecode(response.body);
  }

  Color get_district_color(value, category) => _randomColor.randomColor(
      colorHue: (category == 'Confirmed')
          ? ColorHue.red
          : (category == 'Recovered')
              ? ColorHue.green
              : (category == 'Active')
                  ? ColorHue.blue
                  : ColorHue.yellow,
      colorBrightness: ColorBrightness.veryLight);

  // ignore: non_constant_identifier_names
  _get_color() {
    if (widget.category == "Confirmed") {
      setState(() {
        this.color = Color.fromRGBO(77, 17, 41, 1);
        this.text_color = Colors.red;
      });
    } else if (widget.category == "Recovered") {
      setState(() {
        this.color = Color.fromRGBO(24, 40, 40, 1);
        this.text_color = Colors.green;
      });
    } else if (widget.category == "Active") {
      setState(() {
        this.color = Color.fromRGBO(21, 29, 51, 1);
        this.text_color = Colors.blue;
      });
    } else {
      setState(() {
        this.color = Color.fromRGBO(28, 28, 43, 1);
        this.text_color = Colors.white60;
      });
    }
  }

  // ignore: non_constant_identifier_names
  _get_district_cases() async {
    var response =
        await http.get('https://api.covid19india.org/state_district_wise.json');
    return convert.jsonDecode(response.body);
  }

  _selectcategory(categorycontext) {
    Alert(
        context: categorycontext,
        style: AlertStyle(
            backgroundColor: Color.fromRGBO(22, 22, 37, 1),
            titleStyle: GoogleFonts.oswald(fontSize: 18, color: text_color)),
        title: 'Select period',
        buttons: [
          DialogButton(
            child: Row(children: [
              Container(
                child: Icon(
                  FlutterIcons.calendar_week_faw5s,
                  color: text_color,
                ),
                margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
              ),
              Container(
                child: Text(
                  '7 Days',
                  style: GoogleFonts.oswald(fontSize: 16, color: text_color),
                ),
              )
            ]),
            radius: BorderRadius.circular(15),
            color: color,
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
                  color: text_color,
                ),
                margin: EdgeInsets.fromLTRB(5, 5, 10, 5),
              ),
              Container(
                child: Text(
                  '30 Days',
                  style: GoogleFonts.oswald(fontSize: 16, color: text_color),
                ),
              )
            ]),
            radius: BorderRadius.circular(15),
            color: color,
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
          cornerRadius: 16,
          color: Color.fromRGBO(22, 22, 37, 1),
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.8, 0.9, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return Container(
              child: Column(children: [
                Container(
                  child: Text(
                    'Daily Report',
                    style:
                        GoogleFonts.oswald(color: Colors.white, fontSize: 18),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
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
                      zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
                      //backgroundColor: Color.fromRGBO(77,17,41,1),
                      series: <ChartSeries>[
                        LineSeries<BarData, DateTime>(
                            opacity: 1,
                            enableTooltip: true,
                            dataSource: this.state_daily,
                            pointColorMapper: (BarData bar, _) =>
                                set_color.get_color(bar.y, widget.category),
                            xValueMapper: (BarData bar, _) => bar.x,
                            yValueMapper: (BarData bar, _) => bar.y / 1000,
                            markerSettings: MarkerSettings(
                                isVisible: true, color: this.text_color),
                            animationDuration: 1,
                            color: (widget.category == 'Confirmed')
                                ? Colors.red[400]
                                : (widget.category == 'Active')
                                    ? Colors.blue[400]
                                    : (widget.category == 'Recovered')
                                        ? Colors.green[400]
                                        : Colors.grey[400])
                      ]),
                ),
              ]),
              height: 300,
              margin: EdgeInsets.fromLTRB(10, 40, 10, 30),
            );
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
            return Container(
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
                    labelStyle:
                        GoogleFonts.oswald(color: Colors.white, fontSize: 13),
                  ),
                  primaryYAxis: NumericAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    // labelFormat: '{value}K',
                    // labelStyle: GoogleFonts.oswald(color:Colors.white,fontSize: 13)
                  ),
                  borderWidth: 0,
                  zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                      dataSource: data,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      //dataLabelMapper: (ChartData data, _) => data.x,
                      // enableSmartLabels: true,
                      // explode: true,
                    )
                  ]),
              height: 380,
              margin: EdgeInsets.all(5),
            );
          });
    });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Color.fromRGBO(22, 22, 37, 1),
            backgroundColor: Color.fromRGBO(22, 22, 37, 1),
            scaffoldBackgroundColor: Color.fromRGBO(22, 22, 37, 1)),
        home: Scaffold(
            appBar: AppBar(
                title: ResponsiveRow(children: [
              InkWell(
                child: FlexWidget(
                  child: Icon(UniconsLine.arrow_left, size: 30),
                  xs: 1,
                  md: 1,
                  lg: 1,
                  xl: 1,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              FlexWidget(
                child: Container(
                  child: Text(
                    widget.name.toString().toUpperCase(),
                    style: GoogleFonts.oswald(fontSize: 21),
                  ),
                  alignment: Alignment.center,
                ),
                xs: 9,
                xl: 9,
                md: 9,
                lg: 9,
              ),
            ])),
            body: SingleChildScrollView(
                child: Container(
              color: Color.fromRGBO(22, 22, 37, 1),
              child: Column(children: [
                Center(
                  child: Container(
                    child: Center(
                      child: Text(
                          widget.category +
                              "    " +
                              widget.state_cases.toString(),
                          style: GoogleFonts.oswald(
                              color: this.text_color, fontSize: 16)),
                    ),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: this.color),
                    height: 90,
                  ),
                ),
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
                              color: color,
                              onPressed: () => _selectcategory(context),
                            ),
                            alignment: Alignment.center,
                            height: 50,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: color),
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
                              color: color,
                              onPressed: () => _barchart(),
                            ),
                            alignment: Alignment.center,
                            height: 50,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: color),
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
                        label: Center(
                            child: Text("Index",
                                style: GoogleFonts.oswald(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))),
                    DataColumn(
                        label: Center(
                            child: Text("District",
                                style: GoogleFonts.oswald(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))),
                    DataColumn(
                        label: Center(
                            child: Text(widget.category,
                                style: GoogleFonts.oswald(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))),
                  ],
                  rows: this
                      .cases
                      .keys
                      .toList()
                      .reversed
                      .toList()
                      .map((element) => DataRow(cells: [
                            DataCell(Center(
                                child: Text(
                                    (this
                                                .cases
                                                .keys
                                                .toList()
                                                .reversed
                                                .toList()
                                                .indexOf(element) +
                                            1)
                                        .toString(),
                                    style: GoogleFonts.oswald(
                                        fontSize: 15, color: Colors.white)))),
                            DataCell(Text(element,
                                style: GoogleFonts.oswald(
                                    fontSize: 15, color: Colors.white))),
                            DataCell(Center(
                                child: Text(
                                    f.format(this.cases[element]).toString(),
                                    style: GoogleFonts.oswald(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic))))
                          ]))
                      .toList(),
                  columnSpacing: 77,
                  sortColumnIndex: 1,
                )
              ]),
            ))));
  }
}
