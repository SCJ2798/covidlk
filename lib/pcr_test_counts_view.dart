import 'package:countup/countup.dart';
import 'package:covid/config/ColorConfig.dart';
import 'package:covid/model/covid_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PcrTestCountView extends StatefulWidget {
  List<PcrTest> listpcr;
  PcrTestCountView({this.listpcr});
  @override
  _PcrTestCountViewState createState() => _PcrTestCountViewState(list: listpcr);
}

class _PcrTestCountViewState extends State<PcrTestCountView> {
  List<PcrTest> list;
  _PcrTestCountViewState({this.list});

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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 16.0,
                    height: 16.0,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: kClipColor.withOpacity(0.1)),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: kClipColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "PCR Test Counts",
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
      ),
    );
  }

  Widget pcrInfoCard(PcrTest pcr) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        decoration: BoxDecoration(
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
                Icons.biotech_rounded,
                size: 20,
                color: kIconColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Countup(
                  begin: 0,
                  end: double.parse(pcr.count),
                  duration: Duration(seconds: 1),
                  style: TextStyle(
                      fontSize: 32.0,
                      color: kTxtColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  pcr.date,
                  style: TextStyle(fontSize: 12, color: kTxtColor),
                ),
              ),
            ]));
  }

  List<PcrTest> getRangeOfPcr(int start, int end, List<PcrTest> list) {
    return list.getRange(start, end).toList();
  }
}
