import 'package:flutter/material.dart';

class BlankView extends StatefulWidget {
  const BlankView({Key? key}) : super(key: key);

  @override
  _BlankViewState createState() => _BlankViewState();
}

class _BlankViewState extends State<BlankView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Blank View'),
    );
  }
}
