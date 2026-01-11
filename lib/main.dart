import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple.shade50,
        appBar: AppBar(
          title: const Text("BMI Calculator"),
          backgroundColor: Colors.deepPurple.shade200,
        ),
        body: const BMICalculator(),
      ),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _ComputeBMI();
}

class _ComputeBMI extends State<BMICalculator>{
  String _selectedGender = "M";

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _resultMessage = "";
  Color _resultColor = Colors.deepPurpleAccent;

  void _calculateBMI() {
    String ageText = _ageController.text;
    String heightText = _heightController.text;
    String weightText = _weightController.text;

      //Check if any field is empty
      if(ageText.isEmpty || heightText.isEmpty || weightText.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all of the fields"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
        return;
      }

      //Convert data to numbers
      double? age = double.tryParse(ageText);
      double? height = double.tryParse(heightText);
      double? weight = double.tryParse(weightText);

      //Validate converted data
      if (age == null || height == null || weight == null || 
          age <= 0 || height <= 0 || weight <= 0) {
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please enter valid numbers"),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
            return;
      }

    setState (() {
      //Calculate BMI
      double heightInMeters = height/100;
      double bmi = weight / (heightInMeters*heightInMeters);
      String category = "";

      if (bmi < 18.5) {
        category = "Underweight";
        _resultColor = Colors.blue;
      } else if (bmi < 25) {
        category = "Normal";
        _resultColor = Colors.green;
      } else if (bmi < 30) {
        category = "Overweight";
        _resultColor = Colors.orange;
      } else {
        category = "Obesity";
        _resultColor = Colors.red;
      }

      //Calculate BFP
      int sexModifier = _selectedGender == "M" ? 1:0;
      double bfp = (1.20 * bmi) + (0.23 * age) - (10.8 * sexModifier) - 5.4;
      
      if (bfp < 0) bfp = 0;

      //Display BMI and BFP
      _resultMessage = "BMI: ${bmi.toStringAsFixed(2)} ($category)\n"
                       "BFP: ${bfp.toStringAsFixed(1)}%";
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 50;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
        child: Column(
          children: [
            DropdownMenu<String>(
              width: width,
              initialSelection: _selectedGender,
              label: const Text("Gender"),
              leadingIcon: const Icon(Icons.wc, color: Colors.deepPurple),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(), 
                filled: true,
                fillColor: Colors.white, 
              ),
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: "M", label: "Male"),
                DropdownMenuEntry(value: "F", label: "Female"),
              ],
              onSelected: (String? value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            const SizedBox(height: 10.0),

            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Input your age",
                labelText: "Age",
                suffixText: "(years)",
                prefixIcon: Icon(Icons.person, color: Colors.deepPurple),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              )
            ),
            const SizedBox(height: 10.0),

            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Input your height",
                labelText: "Height",
                suffixText: "(cm)",
                prefixIcon: Icon(Icons.height, color: Colors.deepPurple),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              )
            ),
            const SizedBox(height: 10.0),

            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Input your weight",
                labelText: "Weight",
                suffixText: "(kg)",
                prefixIcon: Icon(Icons.scale, color: Colors.deepPurple),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              )
            ),
            const SizedBox(height: 20.0),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                onPressed: _calculateBMI, 
                child: const Text("Calculate")
              ),
            ),
            const SizedBox(height: 30.0),

            if (_resultMessage.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: _resultColor, 
                    width: 3.0
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  _resultMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _resultColor,
                  ),
                ),
              ),
          ],
        )
      ),
    );
  }
}