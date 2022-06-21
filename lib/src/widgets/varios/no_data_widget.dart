import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  String text = '';
  NoDataWidget({this.text = ''});
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/cero-items.png', height: 180, width: 180,),
          const SizedBox(height: 15,),
          Text(text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}