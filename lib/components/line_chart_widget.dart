import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'line_titles.dart';

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  final List<Color> gradientColors2 = [
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
  ];
  final List<Color> gradientColors3 = [
    Colors.greenAccent,
    Colors.green,
  ];
  final List<Color> gradientColors4 = [
    Colors.purpleAccent,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          titlesData: LineTitles.getTitleData(),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 0.5,
              );
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 0.5,
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 0.7),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 5),
                FlSpot(2.6, 2),
                FlSpot(4.9, 5),
                FlSpot(6.8, 2.5),
                FlSpot(8, 4),
                FlSpot(11, 4),
              ],
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              // dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 0),
                FlSpot(2.6, 5),
                FlSpot(4.9, 2),
                FlSpot(6.8, 3),
                FlSpot(8, 5),
                FlSpot(11, 1),
              ],
              isCurved: true,
              colors: gradientColors2,
              barWidth: 5,
              // dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors2
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 2),
                FlSpot(2.6, 4),
                FlSpot(4.9, 3),
                FlSpot(6.8, 5),
                FlSpot(8, 5),
                FlSpot(11, 1),
              ],
              isCurved: true,
              colors: gradientColors3,
              barWidth: 5,
              // dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors3
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
            LineChartBarData(
              spots: [
                FlSpot(0, 0),
                FlSpot(1, 2),
                FlSpot(4.9, 5),
                FlSpot(6.8, 4),
                FlSpot(8, 4),
                FlSpot(11, 3),
              ],
              isCurved: true,
              colors: gradientColors4,
              barWidth: 5,
              // dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors4
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
          ],
        ),
      );
}
