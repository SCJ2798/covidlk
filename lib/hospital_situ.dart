import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HospitalSitu extends StatefulWidget {
  @override
  _HospitalSituState createState() => _HospitalSituState();
}

class _HospitalSituState extends State<HospitalSitu> {
  @override
  Widget build(BuildContext context) {
    List<String> listString = [
      "A",
      "ASD",
      "CFG",
      "A",
      "ASD",
      "CFG",
      "A",
      "ASD",
      "CFG",
    ];
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Icon(Icons.arrow_back),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: ListView.builder(
              itemCount: listString.length,
              itemBuilder: (context, index) {
                return hospitalInfoCard(listString[index]);
              },
            ),
          )
        ],
      )),
    );
  }

  Widget hospitalInfoCard(String name) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4.0, offset: Offset(0, 0))
            ]),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.date_range,
                    size: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("NOV 10"),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4.0),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.25)),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Countup(
                      begin: 0,
                      end: 100.0,
                      duration: Duration(seconds: 3),
                      style: TextStyle(fontSize: 24.0),
                    ),
                  )
                ],
              ),
            ]));
  }
}