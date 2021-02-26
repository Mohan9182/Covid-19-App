import 'package:flutter/material.dart';

class ChartData {
    ChartData(this.x, this.y, [this.color]);
    final String x;
    final int y;
    final Color color;
}

class PieData{
  PieData(this.x,this.y,[this.color]);
  final String x;
  final double y;
  final Color color;
}

class BarData {
  BarData(this.x, this.y);
  final DateTime x;
  final int y;
}