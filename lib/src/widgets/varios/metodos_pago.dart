import 'package:flutter/material.dart';

enum MetodosDePagoOptions { contraRembolso, tarjeta, enTienda }

class MetodosPago extends StatefulWidget {
  const MetodosPago({Key? key}) : super(key: key);

  @override
  State<MetodosPago> createState() => _MetodosPagoState();
}

class _MetodosPagoState extends State<MetodosPago> {
  MetodosDePagoOptions? _metodoDePago = MetodosDePagoOptions.contraRembolso;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Contra rembolso'),
          leading: Radio<MetodosDePagoOptions>(
            value: MetodosDePagoOptions.contraRembolso,
            groupValue: _metodoDePago,
            onChanged: (MetodosDePagoOptions? value) {
              setState(() {
                _metodoDePago = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Tarjeta'),
          leading: Radio<MetodosDePagoOptions>(
            value: MetodosDePagoOptions.tarjeta,
            groupValue: _metodoDePago,
            onChanged: (MetodosDePagoOptions? value) {
              setState(() {
                _metodoDePago = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Pago en tienda'),
          leading: Radio<MetodosDePagoOptions>(
            value: MetodosDePagoOptions.enTienda,
            groupValue: _metodoDePago,
            onChanged: (MetodosDePagoOptions? value) {
              setState(() {
                _metodoDePago = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
