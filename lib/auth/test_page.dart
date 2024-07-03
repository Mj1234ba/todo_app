import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Bakri'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.red,
        ),
      ),
    );
  }
}
