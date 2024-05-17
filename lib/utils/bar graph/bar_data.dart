import 'individual_bar.dart';

class BarData {
  final int sunAmount;
  final int monAmount;
  final int tueAmount;
  final int wedAmount;
  final int thurAmount;
  final int friAmount;
  final int satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.satAmount,
    required this.friAmount,
  });

  List<IndividualBar> barData = [];


  void initializeBarData() {
    barData =[
      IndividualBar(x: 0, y: sunAmount),
      IndividualBar(x: 1, y: monAmount),
      IndividualBar(x: 2, y: tueAmount),
      IndividualBar(x: 3, y: wedAmount),
      IndividualBar(x: 4, y: thurAmount),
      IndividualBar(x: 5, y: satAmount),
      IndividualBar(x: 6, y: friAmount),

    ];
  }
}
