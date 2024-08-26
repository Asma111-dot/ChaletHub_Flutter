import 'package:chalet_2/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PoliciesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Policies and Terms ',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: Center(
        child: Text('Policies and Terms Content Here'),
      ),
    );
  }
}
