import 'package:covid/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info/package_info.dart';

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About App",
          style: TextStyle(color: kTxtColor),
        ),
        shadowColor: Colors.white.withOpacity(0.0),
        iconTheme: IconThemeData(color: kIconColor),
        backgroundColor: Colors.black.withOpacity(0.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/virus_bg.png'),
            ),
          ),
          child: FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return appInfo(snapshot.data);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget appInfo(PackageInfo packInfo) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.coronavirus,
                  size: 32.0,
                  color: kIconColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "CovidLK",
                  style: TextStyle(fontSize: 32, color: kTxtColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              "Covid 19 Realtime Situation Report",
              style: TextStyle(
                color: kTxtColor,
                letterSpacing: 2.0,
                fontSize: 8.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              "Sri Lanka & World",
              style: TextStyle(
                color: kTxtColor,
                letterSpacing: 1.0,
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              "v" + packInfo.version + "." + packInfo.buildNumber,
              style: TextStyle(
                color: kTxtColor,
                letterSpacing: 1.0,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              "Developed by",
              style: TextStyle(
                color: kTxtColor,
                fontSize: 12.0,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/img/my.jpg",
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.height * 0.06,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chathuranga Jayawardana",
                        style: TextStyle(fontSize: 12.0, color: kTxtColor),
                      ),
                      Text(
                        "SCJ101",
                        style: TextStyle(
                          fontSize: 8.0,
                          color: kTxtColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              "Source",
              style: TextStyle(
                color: kTxtColor,
                letterSpacing: 0.0,
                fontSize: 12.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              "Health Promotion Bureau , Sri Lanka",
              style: TextStyle(
                color: kTxtColor,
                letterSpacing: 0.0,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.045,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "SCJ101",
              style: TextStyle(
                  color: kTxtColor,
                  letterSpacing: 0.0,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/facebook.svg"),
                  SizedBox(width: 12.0),
                  SvgPicture.asset("assets/svg/instagram.svg"),
                  SizedBox(width: 12.0),
                  SvgPicture.asset("assets/svg/linkedin.svg"),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "All rights Reserved.. Copyright SCJ101",
              style: TextStyle(
                color: kTxtColor.withOpacity(0.5),
                letterSpacing: 0.0,
                fontSize: 8.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
