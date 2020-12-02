import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidData {
  String message;
  bool status;
  SubData data;

  CovidData({this.message, this.status, this.data});

  factory CovidData.fromJson(Map<String, dynamic> jsn) {
    return CovidData(
        status: jsn['success'],
        message: jsn['message'],
        data: SubData.fromJson(jsn['data']));
  }
}

class SubData {
  String localNewCases;
  String localDeath;
  String localTotal;
  String localRecover;
  String localNewDeath;
  String localActiveCases;

  String globalNewCases;
  String globalDeath;
  String globalTotal;
  String globalRecover;
  String globalNewDeath;
  String globalActiveCases;
  String last_update;

  String total_pcr;

  TestData testData;
  HospitalData hospitalData;

  List<PcrTest> listPcr;
  List<HospitalSituation> listHospitalSitu;

  SubData(
      {this.last_update,
      this.localNewCases,
      this.localDeath,
      this.localTotal,
      this.localRecover,
      this.localActiveCases,
      this.localNewDeath,
      this.globalNewCases,
      this.globalDeath,
      this.globalTotal,
      this.globalRecover,
      this.globalActiveCases,
      this.globalNewDeath,
      this.testData,
      this.hospitalData,
      this.total_pcr,
      this.listHospitalSitu,
      this.listPcr});

  // ignore: missing_return
  factory SubData.fromJson(Map<String, dynamic> _jsn) {
    List<dynamic> barChatR = _jsn['daily_pcr_testing_data'];
    List<dynamic> hospitalData = _jsn['hospital_data'];
    List<dynamic> pcrTestData = _jsn['daily_pcr_testing_data'];

    // set range
    List<dynamic> barChat =
        barChatR.getRange(barChatR.length - 10, barChatR.length).toList();

    List<FlSpot> chartSpot_group = [];
    List<String> dt = [];
    List<BarChartGroupData> hospital_group_data = [];

    List<PcrTest> listPcrTest = [];
    List<HospitalSituation> listHospitalData = [];

    // Add total pcr
    pcrTestData.asMap().forEach((key, pcr) {
      listPcrTest.add(PcrTest(id: key, count: pcr['count'], date: pcr['date']));
    });

    // Add 07 day pcr
    barChat.asMap().forEach((key, value) {
      Map<String, dynamic> valMap = value;

      chartSpot_group.add(FlSpot(double.parse(key.toString()),
          double.parse(valMap['count'].toString())));

      List<String> tDate = valMap['date'].toString().split('-');
      dt.add(tDate[1] + "/" + tDate[2]);
    });

    hospitalData.asMap().forEach((key, value) {
      Map<String, dynamic> valMap = value;

      listHospitalData.add(HospitalSituation(
          id: key.toInt(),
          name: value['hospital']['name'],
          cumTotal: value['cumulative_total'].toString(),
          treatTotal: value['treatment_total'].toString()));

      hospital_group_data
          .add(BarChartGroupData(x: int.parse(key.toString()), barRods: [
        BarChartRodData(
          y: double.parse(valMap['cumulative_total'].toString()),
          colors: [Colors.teal.shade800.withOpacity(0.75)],
          width: 12.0,
        ),
      ]));
    });

    try {
      return SubData(
          last_update: _jsn['update_date_time'].toString(),
          localNewCases: _jsn['local_new_cases'].toString(),
          localDeath: _jsn['local_deaths'].toString(),
          localTotal: _jsn['local_total_cases'].toString(),
          localRecover: _jsn['local_recovered'].toString(),
          localActiveCases: _jsn['local_active_cases'].toString(),
          localNewDeath: _jsn['local_new_deaths'].toString(),
          globalNewCases: _jsn['global_new_cases'].toString(),
          globalDeath: _jsn['global_deaths'].toString(),
          globalTotal: _jsn['global_total_cases'].toString(),
          globalRecover: _jsn['global_recovered'].toString(),
          globalActiveCases:
              (_jsn['global_total_cases'] - _jsn['global_recovered'])
                  .toString(),
          globalNewDeath: _jsn['global_new_deaths'].toString(),
          total_pcr: _jsn['total_pcr_testing_count'].toString(),
          testData: TestData(
              date: dt,
              chartSpot: chartSpot_group,
              totalpcr: _jsn['total_pcr_testing_count'].toString()),
          hospitalData: HospitalData(barGroupData: hospital_group_data),
          listHospitalSitu: listHospitalData,
          listPcr: listPcrTest);
    } catch (err) {
      print('ERROR - $err ');
      return null;
    }
  }
}

class TestData {
  String totalpcr;
  List<String> date;
  List<FlSpot> chartSpot = [];

  TestData({this.date, this.chartSpot, this.totalpcr});
}

class HospitalData {
  String name;
  String id;
  String cum_total;
  String treament_total;
  List<BarChartGroupData> barGroupData = [];

  HospitalData(
      {this.name,
      this.id,
      this.cum_total,
      this.treament_total,
      this.barGroupData});
}

// ---

class PcrTest {
  int id;
  String date;
  String count;

  PcrTest({this.id, this.date, this.count});
}

class HospitalSituation {
  int id;
  String name;
  String cumTotal;
  String treatTotal;

  HospitalSituation({this.id, this.name, this.cumTotal, this.treatTotal});
}
