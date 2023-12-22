import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NumberExtensions on num {
  double toFontSize() => toDouble();
  Widget toColumnSpace() => SizedBox(height: toDouble(),);
  Widget toRowSpace() => SizedBox(width: toDouble(),);
  String formattedMoney({String currency = ""}) {
    var f = NumberFormat('#,###.00#');
    return "$currency${f.format(this)}";
  }
}