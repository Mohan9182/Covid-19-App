import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ssh_app/homepage.dart';
import 'dart:convert' as convert;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ssh_app/model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  List<List<BarData>> daily = [];
  var dates = List<DateTime>.generate(
      30, (i) => DateTime.now().subtract(Duration(days: i + 1)));
  // ignore: non_constant_identifier_names
  var india_cases = [],
      state_codes = [],
      state_names = [],
      district_names = {},
      news;

  @override
  void initState() {
    startTime();
    _get_news().then((jsonResponse) {
      setState(() {
        this.news = jsonResponse["articles"];
      });
    });
    _get_state_details().then((jsonResponse) {
      jsonResponse["state_meta_data"].forEach((f) {
        var code = f["abbreviation"];
        var name = f["stateut"];
        if (!["TT", "UN"].contains(code) && name != 'Lakshadweep') {
          setState(() {
            this.state_codes.add(code);
            this.state_names.add(name);
          });
        }
      });
    });
    _get_district_details().then((jsonResponse) {
      jsonResponse["district_meta_data"].forEach((f) {
        if (f["state"] != 'Lakshadweep') {
          if (!this.district_names.containsKey(f["state"])) {
            this.district_names[f["state"]] = [];
          }
          setState(() {
            this.district_names[f["state"]].add(f["district"]);
          });
        }
      });
    });
    _get_daily_changes().then((jsonResponse) {
      var states = jsonResponse["states_daily"];
      List<BarData> confirmed = [], active = [], recovered = [], deaths = [];
      dates.forEach((d) {
        var value = (d.difference(DateTime(2020, 3, 14)).inDays) * 3;
        confirmed.add(BarData(d, int.parse(states[value]["tt"])));
        active.add(BarData(
            d,
            int.parse(states[value]["tt"]) -
                int.parse(states[value + 1]["tt"]) -
                int.parse(states[value + 2]["tt"])));
        recovered.add(BarData(d, int.parse(states[value + 1]["tt"])));
        deaths.add(BarData(d, int.parse(states[value + 2]["tt"])));
      });
      this.daily.add(confirmed);
      this.daily.add(active);
      this.daily.add(recovered);
      this.daily.add(deaths);
    });
    super.initState();
  }

  // ignore: non_constant_identifier_names
  _get_news() async {
    var response = await http.get(
        "https://covid-19-news.p.rapidapi.com/v1/covid?q=covid&lang=en&country=in&page=1&page_size=10&media=True",
        headers: {
          "x-rapidapi-key":
              "789d22491amsh9cf6fe5ac3b3cf8p195e80jsn0b807e6d418c",
          "x-rapidapi-host": "covid-19-news.p.rapidapi.com"
        });
    return convert.jsonDecode(response.body);
  }

  // ignore: non_constant_identifier_names
  _get_daily_changes() async {
    var response =
        await http.get('https://api.covid19india.org/states_daily.json');
    return convert.jsonDecode(response.body);
  }

  // ignore: non_constant_identifier_names
  _get_state_details() async {
    var response = await http.get('https://api.covid19india.org/misc.json');
    return convert.jsonDecode(response.body);
  }

  // ignore: non_constant_identifier_names
  _get_district_details() async {
    var response = await http.get('https://api.covid19india.org/misc.json');
    return convert.jsonDecode(response.body);
  }

  startTime() async {
    var duration = new Duration(seconds: 4);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  state_codes: this.state_codes,
                  state_names: this.state_names,
                  district_names: this.district_names,
                  india_cases: this.india_cases,
                  confirmed_cases: {},
                  active_cases: {},
                  recovered_cases: {},
                  deaths_cases: {},
                  index: 0,
                  daily: this.daily,
                  news: this.news,
                )));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset("assets/icon.png"),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            width: 250,
            height: 250,
          ),
          Container(
              child: Text(
            "COVID-19",
            style: GoogleFonts.oswald(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          )),
          Container(
              child: Text("Tracker\n",
                  style: GoogleFonts.oswald(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          Container(
              child: SpinKitCircle(
            color: Colors.white,
            duration: Duration(milliseconds: 800),
          ))
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(22, 22, 37, 1)),
      home: initScreen(context),
    );
  }
}
