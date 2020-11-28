import 'package:countup/countup.dart';
import 'package:covid/hospital_situ.dart';
import 'package:covid/model/covid_data.dart';
import 'package:covid/pcr_test_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FirstActivity extends StatefulWidget {
  SubData subdata;
  FirstActivity({this.subdata});
  @override
  First_State createState() => First_State(subdata: subdata);
}

class First_State extends State<FirstActivity> {
  SubData subdata;
  CvData cvData;

  First_State({this.subdata});
  List<bool> isSelected = [true, false];

  @override
  void initState() {
    super.initState();
    cvData = CvData.forLocal(subdata);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.white,
            ),
            // padding: EdgeInsets.symmetric(vertical: 8.0),
            // color: Colors.white,
            child: ToggleButtons(
                borderWidth: 0.0,
                color: Colors.black,
                selectedColor: Colors.white,
                fillColor: Colors.teal.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24.0),
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.home, size: 16.0),
                          SizedBox(width: 2.0),
                          Text('Local')
                        ]),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.language, size: 16.0),
                          SizedBox(width: 2.0),
                          Text('Global')
                        ]),
                  ),
                ],
                onPressed: (int index) {
                  print(index);
                  setState(() {
                    if (index == 0) {
                      isSelected = [true, false];
                      cvData = CvData.forLocal(subdata);
                    } else {
                      isSelected = [false, true];
                      cvData = CvData.forGobal(subdata);
                    }
                  });
                },
                isSelected: isSelected),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Last Updated:", style: TextStyle(fontSize: 8.0)),
                SizedBox(width: 4.0),
                Text(subdata.last_update, style: TextStyle(fontSize: 8.0))
              ],
            ),
          ),
          Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 8,
              spacing: 8,
              children: [
                ViewCard(
                    count: cvData.newcase,
                    name: 'New Cases',
                    icondata: Icons.airline_seat_flat),
                ViewCard(
                    count: cvData.newdeath,
                    name: 'New Deaths',
                    icondata: Icons.hotel),
                ViewCard(
                    count: cvData.active,
                    name: 'Active Cases',
                    icondata: Icons.hotel),
                ViewCard(
                    count: cvData.deaths,
                    name: 'Deaths',
                    icondata: Icons.hotel),
                ViewCard(
                    count: cvData.totalcase,
                    name: 'Total Cases',
                    icondata: Icons.hotel),
                ViewCard(
                    count: cvData.recovery,
                    name: 'Recovers',
                    icondata: Icons.hotel),
              ]),
          SizedBox(height: 24.0),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 3))
                ]),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.biotech_outlined),
                      Text("PCR Tests"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                  child: AspectRatio(
                      aspectRatio: 1.8,
                      child: LineChart(LineChartData(
                          gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              drawHorizontalLine: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: subdata.testData.chartSpot,
                              belowBarData: BarAreaData(show: false),
                              colors: [Colors.green],
                              barWidth: 2.0,
                              isCurved: true,
                            )
                          ],
                          borderData: FlBorderData(
                            show: false,
                          ),
                          titlesData: FlTitlesData(
                              leftTitles: SideTitles(showTitles: false),
                              bottomTitles: SideTitles(
                                showTitles: true,
                                margin: 32.0,
                                getTitles: getTestDate,
                                getTextStyles: getTextSty,
                              ))))),
                ),
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                    child: FlatButton(
                        child: Container(
                            padding: EdgeInsets.all(4.0),
                            child: Text('See more')),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              print(subdata.listPcr[0].count);
                              return PcrView(subData: subdata);
                            },
                          ));
                        }))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 3))
                ]),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_hospital_outlined),
                      SizedBox(width: 12.0),
                      Text("Hospital's Situation"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: AspectRatio(
                            aspectRatio: 4.6,
                            child: BarChart(BarChartData(
                                barGroups: subdata.hospitalData.barGroupData,
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                titlesData: FlTitlesData(
                                    leftTitles: SideTitles(showTitles: false),
                                    bottomTitles: SideTitles(
                                      showTitles: true,
                                      margin: 16.0,
                                      getTextStyles: getTextSty,
                                    ))))),
                      ),
                    ),
                  ),
                ),
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                    child: FlatButton(
                        child: Text('See More'),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HospitalSitu(subData: subdata);
                          }));
                        }))
              ],
            ),
          )
        ],
      ),
    );
  }

  String getTestDate(double val) {
    return subdata.testData.date[val.toInt()];
  }

  //  String getHospitalName(double val) {
  //    var hosName = ['IDH','']
  //   return subdata.testData.date[val.toInt()];
  // }

  TextStyle getTextSty(double val) {
    return TextStyle(color: Colors.black, fontSize: 8.0);
  }

  List<FlSpot> getSpot() {
    return [
      FlSpot(0, 5),
      FlSpot(1, 2),
      FlSpot(2, 30),
      FlSpot(3, 50),
      FlSpot(4, 18)
    ];
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

class ViewCard extends StatelessWidget {
  IconData icondata;
  String count;
  String name;

  ViewCard({this.count, this.name, this.icondata});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 10.0, offset: Offset(0, 3))
            ]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 16.0,
                    height: 16.0,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal.withOpacity(0.2)),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.teal, width: 1.0),
                          color: Colors.teal.withOpacity(0.9)),
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Text(name, style: TextStyle(fontSize: 14.0))
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Countup(
                            begin: 0.0,
                            end: double.parse(count),
                            duration: Duration(seconds: 2),
                            style: TextStyle(fontSize: 28),
                          )
                        ],
                      ))),
              Text(
                "peoples",
                style: TextStyle(fontSize: 8.0),
              )
            ]));
  }
}

class CvData {
  String newcase;
  String newdeath;
  String active;
  String totalcase;
  String recovery;
  String deaths;

  CvData(
      {this.newcase,
      this.newdeath,
      this.active,
      this.deaths,
      this.recovery,
      this.totalcase});

  factory CvData.forLocal(SubData subData) {
    return CvData(
        newcase: subData.localNewCases,
        active: subData.localActiveCases,
        deaths: subData.localDeath,
        newdeath: subData.localNewDeath,
        recovery: subData.localRecover,
        totalcase: subData.localTotal);
  }

  factory CvData.forGobal(SubData subData) {
    return CvData(
        newcase: subData.globalNewCases,
        active: subData.globalActiveCases,
        deaths: subData.globalDeath,
        newdeath: subData.globalNewDeath,
        recovery: subData.globalRecover,
        totalcase: subData.globalTotal);
  }
}
