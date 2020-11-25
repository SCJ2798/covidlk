import 'package:countup/countup.dart';
import 'package:covid/model/covid_data.dart';
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

  List<String> listText = ["A", "SDF", "SJJS", "A"];
  List<String> filterList = ["week", "month", "All"];
  List<PcrTest> listPcrTest = [];

  @override
  void initState() {
    listPcrTest = getRangeOfPcr(
        subdata.listPcr.length - 10, subdata.listPcr.length, subdata.listPcr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child: Text("PCR Test"),
                    ),
                  ],
                ),
                Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
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
                DropdownButton(
                    underline: Icon(Icons.access_time_outlined),
                    icon: Icon(Icons.arrow_drop_down),
                    items: filterList.map((e) {
                      return DropdownMenuItem(
                          child: Text(e.toString()), value: e.toString());
                    }).toList(),
                    onChanged: (v) {
                      print(v);
                      setState(() {
                        if (v == "week") {
                          listPcrTest = subdata.listPcr
                              .getRange(subdata.listPcr.length - 7,
                                  subdata.listPcr.length)
                              .toList();
                        } else if (v == "month") {
                          listPcrTest = subdata.listPcr
                              .getRange(subdata.listPcr.length - 30,
                                  subdata.listPcr.length)
                              .toList();
                        } else {
                          listPcrTest = subdata.listPcr;
                        }
                      });
                    }),
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
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                  shape: BoxShape.rectangle,
                                  color: Colors.green.withOpacity(0.2)),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: Colors.green, width: 1.0),
                                    color: Colors.green.withOpacity(0.0)),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "PCR Test / Day",
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: AspectRatio(
                            aspectRatio: 2.0,
                            child: LineChart(LineChartData(
                                borderData: FlBorderData(show: false),
                                gridData: FlGridData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: getSpot(listPcrTest),
                                    colors: [Colors.green],
                                    isCurved: true,
                                    dotData: FlDotData(show: false),
                                  )
                                ],
                                titlesData: FlTitlesData(
                                    show: false,
                                    leftTitles: SideTitles(showTitles: false),
                                    bottomTitles: SideTitles(
                                        showTitles: true,
                                        // getTitles: getString,
                                        margin: 32.0)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 16.0,
                              height: 16.0,
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.green.withOpacity(0.2)),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: Colors.green, width: 1.0),
                                    color: Colors.green.withOpacity(0.0)),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "PCR Test Counts",
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(listPcrTest.length,
                                  (index) => pcrInfoCard(listPcrTest[index])),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            )),
      ),
    );
  }

  List<PcrTest> getRangeOfPcr(int start, int end, List<PcrTest> list) {
    return list.getRange(start, end).toList();
  }

  Widget pcrInfoCard(PcrTest pcr) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  width: 1.0,
                  color: Colors.black.withOpacity(0.25),
                  style: BorderStyle.solid)),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment_ind,
                size: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Countup(
                  begin: 0,
                  end: double.parse(pcr.count),
                  duration: Duration(seconds: 1),
                  style: TextStyle(fontSize: 32.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  pcr.date,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ]));
  }

  List<FlSpot> getSpot(List<PcrTest> list) {
    List<FlSpot> listFl = [];
    list.asMap().forEach((key, value) =>
        listFl.add(FlSpot((key).toDouble(), double.parse(value.count))));
    return listFl;
  }

  String getString(double val) {
    var t = ["11", "12", "13", "14", "15"];
    return t[val.toInt()];
  }
}
