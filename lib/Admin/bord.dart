import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:mystore/components/default_button.dart';
import 'package:pie_chart/pie_chart.dart';

import '../SizeConfig.dart';

class AdminBord extends StatefulWidget with NavigationStates {
  @override
  _AdminBordState createState() => _AdminBordState();
}

class _AdminBordState extends State<AdminBord> {
  Map<String, double> dataMap = {
    'Daily Total': 680,
    'Completed Orders ': 330,
    'New Registrations': 200
  };
  List<Color> colorList = [
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.blueAccent
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(20, 80, 10, 5),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
              left: 100.0,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "assets/images/coffee2.png",
                  width: 150.0,
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              right: -180.0,
              child: Image.asset(
                "assets/images/square.png",
              ),
            ),
            Positioned(
              child: Image.asset(
                "assets/images/drum.png",
              ),
              left: -70.0,
              bottom: -40.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                  height: 200.0,
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: SizeConfig.screenWidth,
                        child: PieChart(
                          chartType: ChartType.ring,
                          ringStrokeWidth: 24,
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 1000),
                          chartLegendSpacing: 64,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                        )),
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 220, 10, 10),
              child: Container(
                  height: 350.0,
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      width: SizeConfig.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.color_filter,
                            color: Colors.red,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 570, 10, 10),
              child: Container(
                  height: 100.0,
                  child: Container(
                    width: SizeConfig.screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DefaultButton(
                          text: "View Report",
                          press: () {},
                          submitted: false,
                        ),
                        DefaultButton(
                          text: "Generate Report",
                          press: () {
                            Navigator.pop(context);
                          },
                          submitted: false,
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
