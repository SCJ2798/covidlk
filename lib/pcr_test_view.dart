import 'package:countup/countup.dart';
import 'package:covid/model/covid_data.dart';
import 'package:covid/pcr_test_counts_view.dart';
import 'package:covid/pcr_test_graph.dart';
import 'package:covid/service/service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PcrView extends StatefulWidget {
  SubData subData;
  PcrView({this.subData});

  @override
  _State createState() => _State(subdata: subData);
}

class _State extends State<PcrView> {
  SubData subdata;

  _State({this.subdata});

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/lanka.png"),
                  fit: BoxFit.cover)),
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "PCR Test",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4.0,
                            offset: Offset(0, 0))
                      ]),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(6.0),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green.withOpacity(0.1)),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 1),
                                    shape: BoxShape.circle,
                                    color: Colors.green.withOpacity(0.0)),
                              ),
                            ),
                            SizedBox(width: 10),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Total'))
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 12.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Countup(
                                begin: 0,
                                end: double.parse(subdata.total_pcr),
                                duration: Duration(seconds: 3),
                                style: TextStyle(fontSize: 24.0),
                              ),
                            )
                          ],
                        ),
                      ])),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12.0,
                          offset: Offset(0, 0))
                    ],
                  ),
                  child: PcrTestGraph(pcrlist: subdata.listPcr)),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12.0,
                          offset: Offset(0, 0))
                    ],
                  ),
                  child: PcrTestCountView(listpcr: subdata.listPcr)),
            ],
          )),
    ));
  }

  String getString(double val) {
    var t = ["11", "12", "13", "14", "15"];
    return t[val.toInt()];
  }
}
