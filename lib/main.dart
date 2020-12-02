import 'dart:async';
import 'package:covid/about_us.dart';
import 'package:covid/first_activity.dart';
import 'package:covid/model/covid_data.dart';
import 'package:covid/service/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './config/ColorConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CovidLK',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeState(),
    );
  }
}

class HomeState extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomeState> {
  Future<CovidData> covid_data;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/lanka.png"), fit: BoxFit.cover)),
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 175,
                  child: Stack(children: [
                    ClipPath(
                        clipper: TopCliper(),
                        child: Container(
                          height: 500,
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.teal.shade800,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.035),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.coronavirus,
                                            color: Colors.white),
                                        SizedBox(width: 4),
                                        Text("CovidLK",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24))
                                      ]),
                                  Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Text('Covid 19',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.white))),
                                  Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Text('Realtime Situation Report',
                                          style: TextStyle(
                                              fontSize: 8.0,
                                              color: Colors.white))),
                                ]),
                          ),
                        )),
                    Positioned(
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.06,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.error_outline_outlined,
                                  color: kIconColor,
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AboutApp();
                                  }));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.refresh,
                                  color: kIconColor,
                                ),
                                onTap: () {
                                  setState(() {
                                    init();
                                  });
                                },
                              ),
                            ),
                          ],
                        )),
                  ]),
                ),
                FutureBuilder(
                    future: covid_data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) if (snapshot.data.status)
                        return FirstActivity(subdata: snapshot.data.data);
                      else
                        return lostConnectionCard();
                      else if (snapshot.hasError)
                        return errorCard();
                      else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 200.0),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  init();
                                });
                              },
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    covid_data = new HttpService().fetchData();
    print(covid_data.toString());
  }

  Widget lostConnectionCard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 16.0, offset: Offset(0, 3))
          ]),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Icon(
              Icons.signal_cellular_off,
              color: kIconColor,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              "No Internet Connection",
              style: TextStyle(color: kTxtColor),
            ),
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
            color: kButtonBgColor,
            textColor: kButtonTxtColor,
            onPressed: () {
              setState(() {
                init();
              });
            },
            child: Text("Try Again"),
          ),
        ],
      ),
    );
  }

  Widget errorCard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 16.0, offset: Offset(0, 3))
          ]),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Icon(
              Icons.error_outline_outlined,
              color: kIconColor,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              "Error",
              style: TextStyle(color: kTxtColor),
            ),
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
            color: kButtonBgColor,
            textColor: kButtonTxtColor,
            onPressed: () {
              setState(() {
                init();
              });
            },
            child: Text("Try Again"),
          ),
        ],
      ),
    );
  }
}

class TopCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.625);
    path.quadraticBezierTo(size.width * 0.425, size.height * 1,
        size.width * 0.925, size.height * 0);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
