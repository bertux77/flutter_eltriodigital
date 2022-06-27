import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/My_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class UtilsPage extends StatelessWidget {
  const UtilsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Utils',
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: const Center(child: Text('Utils Page')),
    );
  }
}
