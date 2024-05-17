import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:hospital_managements/utils/bar%20graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List weeklSummary;

  const MyBarGraph({super.key, required this.weeklSummary});

  @override
  Widget build(BuildContext context) {
    int isMode =1;
    BarData myBarData = BarData(
      sunAmount: weeklSummary[0],
      monAmount: weeklSummary[1],
      tueAmount: weeklSummary[2],
      wedAmount: weeklSummary[3],
      thurAmount: weeklSummary[4],
      satAmount: weeklSummary[5],
      friAmount: weeklSummary[6],
    );
    myBarData.initializeBarData();

    return BarChart(BarChartData(
      maxY: 20,
      minY: 0,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTitles,
          ),
        ),
      ),
      barGroups: myBarData.barData
          .map((data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                      toY: data.y.toDouble(),
                      color: AppTheme.getModeColor(AppTheme.lightBlue, AppTheme.darkBlue, isMode),
                      width: 30,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 20,
                        color: Colors.grey[200],
                      )),
                ],
              ))
          .toList(),
    ));
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.blueAccent,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  late Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('S', style: style);
      break;
    case 1:
      text = const Text('M', style: style);
      break;
    case 2:
      text = const Text('T', style: style);
      break;
    case 3:
      text = const Text('W', style: style);
      break;
    case 4:
      text = const Text('T', style: style);
      break;
    case 5:
      text = const Text('F', style: style);
      break;
    case 6:
      text = const Text('S', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}

