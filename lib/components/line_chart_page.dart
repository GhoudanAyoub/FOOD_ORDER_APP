import 'package:flutter/material.dart';

import 'line_chart_widget.dart';

class LineChartPage extends StatelessWidget {
  String dropdownValue = 'Month';
  @override
  Widget build(BuildContext context) => Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: LineChartWidget()),
      );
}
