import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:covid/config/ColorConfig.dart';

import 'model/covid_data.dart';

class PcrTestGraph extends StatefulWidget {
  List<PcrTest> pcrlist;
  PcrTestGraph({this.pcrlist});

  @override
  _PcrTestGraphState createState() => _PcrTestGraphState(list: pcrlist);
}

class _PcrTestGraphState extends State<PcrTestGraph> {
  List<PcrTest> list;
  _PcrTestGraphState({this.list});

  List<String> filterList = ["All", "7 days", "30 days"];
  List<PcrTest> listPcrTest = [];
  String selected_text;

  @override
  void initState() {
    super.initState();
    listPcrTest = getRangeOfPcr(list.length - 7, list.length, list);
    selected_text = filterList[1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: kClipColor.withOpacity(0.2)),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: kClipColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Text(
                      "PCR Test / Day",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: kTxtColor,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
                child: DropdownButton(
                    hint: Text(
                      selected_text,
                      style: TextStyle(color: kTxtColor),
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    items: filterList.map((e) {
                      return DropdownMenuItem(
                          child: Text(
                            e.toString(),
                            style: TextStyle(color: kTxtColor),
                          ),
                          value: e.toString());
                    }).toList(),
                    onChanged: (v) {
                      print(v);
                      setState(() {
                        setState(() {
                          if (v == filterList[1]) {
                            listPcrTest = getRangeOfPcr(
                                list.length - 7, list.length, list);
                            selected_text = filterList[1];
                          } else if (v == filterList[2]) {
                            listPcrTest = getRangeOfPcr(
                                list.length - 30, list.length, list);
                            selected_text = filterList[2];
                          } else {
                            listPcrTest = list;
                            selected_text = filterList[0];
                          }
                        });
                      });
                    }),
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
                        colors: [kGraphColor],
                        isCurved: true,
                        dotData: FlDotData(show: false),
                        barWidth: 1.5)
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
    );
  }

  List<FlSpot> getSpot(List<PcrTest> list) {
    List<FlSpot> listFl = [];
    list.asMap().forEach((key, value) =>
        listFl.add(FlSpot((key).toDouble(), double.parse(value.count))));
    return listFl;
  }

  List<PcrTest> getRangeOfPcr(int start, int end, List<PcrTest> list) {
    return list.getRange(start, end).toList();
  }
}
