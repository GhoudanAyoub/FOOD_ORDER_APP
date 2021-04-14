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
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            Image.asset('assets/images/pl.png', width: 100, height: 100),
          ],
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.red[600],
                  Colors.grey.withOpacity(0),
                ]),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
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
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
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
