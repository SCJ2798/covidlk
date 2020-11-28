import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'model/covid_data.dart';

class HospitalSitu extends StatefulWidget {
  SubData subData;
  HospitalSitu({this.subData});

  @override
  _HospitalSituState createState() => _HospitalSituState(subdata: subData);
}

class _HospitalSituState extends State<HospitalSitu> {
  SubData subdata;
  _HospitalSituState({this.subdata});

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
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/lanka.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Hospital's Situation.",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: ListView.builder(
                  itemCount: subdata.listHospitalSitu.length,
                  itemBuilder: (context, index) {
                    return hospitalInfoCard(subdata.listHospitalSitu[index]);
                  },
                ),
              )
            ],
          )),
    );
  }

  Widget hospitalInfoCard(HospitalSituation hs) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4.0, offset: Offset(0, 0))
            ]),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 8.0,
                        ),
                        child: Text("Id", style: TextStyle(fontSize: 8.0)),
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 8.0,
                        ),
                        child: Text(hs.id.toString(),
                            style: TextStyle(fontSize: 16.0)),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 8.0,
                        ),
                        child: Text("Hospital Name",
                            style: TextStyle(fontSize: 8.0)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 8.0,
                        ),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(hs.name, style: TextStyle(fontSize: 16.0)),
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
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
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Countup(
                            begin: 0,
                            end: double.parse(hs.cumTotal),
                            duration: Duration(seconds: 3),
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Cumulative",
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    Column(
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
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Countup(
                            begin: 0,
                            end: double.parse(hs.treatTotal),
                            duration: Duration(seconds: 3),
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child:
                              Text("Treatment", style: TextStyle(fontSize: 12)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ]));
  }
}
