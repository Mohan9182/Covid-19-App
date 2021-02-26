import 'package:flutter/material.dart';

// ignore: camel_case_types
class set_color {
  // ignore: non_constant_identifier_names
  static Color get_color(value, category) {
    if (category == "Confirmed") {
      if (value <= 10000)
        return Colors.red[100];
      else if (value > 10000 && value <= 150000)
        return Colors.red[300];
      else if (value > 150000 && value <= 300000)
        return Colors.red[500];
      else
        return Colors.red[700];
    } else if (category == 'Active') {
      if (value <= 5000)
        return Colors.blue[100];
      else if (value > 5000 && value <= 15000)
        return Colors.blue[300];
      else if (value > 15000 && value <= 40000)
        return Colors.blue[500];
      else
        return Colors.blue[700];
    } else if (category == 'Recovered') {
      if (value <= 10000)
        return Colors.green[100];
      else if (value > 10000 && value <= 150000)
        return Colors.green[300];
      else if (value > 150000 && value <= 300000)
        return Colors.green[500];
      else
        return Colors.green[700];
    } else {
      if (value <= 1000)
        return Colors.grey[100];
      else if (value > 1000 && value <= 5000)
        return Colors.grey[300];
      else if (value > 5000 && value <= 15000)
        return Colors.grey[500];
      else
        return Colors.grey[700];
    }
  }

  static Color get_world_color(value, category) {
    if (category == "Confirmed") {
      if (value <= 100000)
        return Colors.red[100];
      else if (value > 100000 && value <= 1500000)
        return Colors.red[300];
      else if (value > 1500000 && value <= 3000000)
        return Colors.red[500];
      else
        return Colors.red[700];
    } else if (category == 'Active') {
      if (value <= 50000)
        return Colors.blue[100];
      else if (value > 50000 && value <= 150000)
        return Colors.blue[300];
      else if (value > 150000 && value <= 400000)
        return Colors.blue[500];
      else
        return Colors.blue[700];
    } else if (category == 'Recovered') {
      if (value <= 100000)
        return Colors.green[100];
      else if (value > 100000 && value <= 1500000)
        return Colors.green[300];
      else if (value > 1500000 && value <= 3000000)
        return Colors.green[500];
      else
        return Colors.green[700];
    } else {
      if (value <= 10000)
        return Colors.grey[100];
      else if (value > 10000 && value <= 50000)
        return Colors.grey[300];
      else if (value > 50000 && value <= 150000)
        return Colors.grey[500];
      else
        return Colors.grey[700];
    }
  }
}
