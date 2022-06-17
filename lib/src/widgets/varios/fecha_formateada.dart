import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FechaFormateada extends StatelessWidget {
  final fecha;
  final TextStyle textStyle;
  const FechaFormateada(
      {Key? key, required this.fecha, required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataBD = DateTime.parse(fecha).toLocal();
    var formatter = DateFormat('dd-MM-yyyy');
    String data = formatter.format(dataBD);
    return Text(
      data,
      style: textStyle,
    );
  }
}
