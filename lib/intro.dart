import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro extends StatelessWidget {
  const Intro({Key key}) : super(key: key);

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
        body: Column(
          children: [
            Container(
              child: Image.asset(
                'assets/icon.png',
                width: 250,
                height: 250,
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.all(30),
            ),
            Container(
              child: Text(
                'COVID-19',
                style: GoogleFonts.oswald(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            ),
            Container(
              child: Text(
                'COVID-19 is a new strain of coronavirus that has not been previously identified in humans. The COVID-19 is the cause of an outbreak of respiratory illness first detected in Wuhan, Hubei province, China.',
                style: GoogleFonts.oswald(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
            ),
            Container(
              child: Text(
                "In COVID-19, 'CO' means 'crowns’, 'VI' for 'Viruses’, and 'D' for the disease.",
                style: GoogleFonts.oswald(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
            ),
            Container(
              child: Text(
                'Coronaviruses are a large family of viruses that are known to cause illness ranging from the common cold to more severe diseases such as Severe Acute Respiratory syndrome (SARS) and Middle East Respiratory Syndrome (MERS).',
                style: GoogleFonts.oswald(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
            )
          ],
        ),
      ),
    );
  }
}
