import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeMenuItem {
  final IconData? icon;
  final String? title;
  final String? subtitle;

  HomeMenuItem(this.title, this.icon, {this.subtitle});
}

final List<HomeMenuItem> homeMenuItems = [
  // HomeMenuItem("Topup", MyFlutterApp.hello_mayor, subtitle: "CASHBACK 2%"),
  // HomeMenuItem("RC Card", MyFlutterApp.blood, subtitle: "CASHBACK 2-3%"),
  HomeMenuItem("Landline", FontAwesomeIcons.intercom, subtitle: "CASHBACK 2%"),
  HomeMenuItem("Electricity", FontAwesomeIcons.idBadge),
  HomeMenuItem("Khanepani", FontAwesomeIcons.water),
  HomeMenuItem("TV", FontAwesomeIcons.tv, subtitle: "CASHBACK 2%"),
  HomeMenuItem("Internet", FontAwesomeIcons.globe, subtitle: "CASHBACK 0.5-5%"),
  HomeMenuItem("E-Learning", FontAwesomeIcons.readme, subtitle: "CASHBACK 2%"),
  HomeMenuItem("Antivirus", FontAwesomeIcons.shieldAlt,
      subtitle: "CASHBACK 30%"),
  HomeMenuItem("Insurance", FontAwesomeIcons.userShield),
  HomeMenuItem("Ride", FontAwesomeIcons.motorcycle, subtitle: "CASHBACK 5%"),
  HomeMenuItem("Share", FontAwesomeIcons.shareSquare),
];

Map<String, double> dataMap = {
  "Flutter": 5,
  "React": 3,
  "Ionic": 2,
};

final List<ChartData> chartData = [
  ChartData('David', 25),
  ChartData('Steve', 38),
  ChartData('Jack', 34),
  ChartData('Others', 52)
];
final List<ChartData> chartData1 = [
  ChartData('D', 12),
  ChartData('Steve', 5),
  ChartData('Jake', 30),
  ChartData('Others', 20)
];

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final dynamic y;
  final Color? color;
}

class Chartbar {
  Chartbar(this.z, this.a, [this.color]);
  final String z;
  final double a;
  final Color? color;
}
