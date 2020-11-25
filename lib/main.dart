import 'package:connectivity/connectivity.dart';
import 'package:covid/first_activity.dart';
import 'package:covid/model/covid_data.dart';
import 'package:covid/service/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
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
                      top: MediaQuery.of(context).size.height * 0.05,
                      child: Icon(Icons.menu)),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.1,
                      child: GestureDetector(
                        child: Icon(Icons.refresh),
                        onTap: () {
                          setState(() {
                            init();
                          });
                        },
                      )),
                ]),
              ),
              FutureBuilder(
                  future: covid_data,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return FirstActivity(subdata: snapshot.data.data);
                    else if (snapshot.hasError)
                      return Text("${snapshot.error.toString()}");
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
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    ));
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
}

await(Future<ConnectivityResult> checkConnectivity) {}