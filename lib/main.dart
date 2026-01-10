import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blueAccent)
    ),
    );
  }
}
