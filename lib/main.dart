import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("BMI Calculator"),
        backgroundColor: Colors.deepPurple.shade200,
        ),
        body: BMICalculator(),
      ),
    );
  }

}

class BMICalculator extends StatefulWidget {
  @override
  _ComputeBMI createState() => _ComputeBMI();
}

class _ComputeBMI extends State<BMICalculator>{
  //Default selected gender is Male
  String _selectedGender = "M";

  //Controller to access user input
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  //Calculated BMI
  String _resultMessage = "";
  Color _resultColor = Colors.deepPurpleAccent;

  void _calculateBMI() {
    //Load user input from controllers
    String ageText = _ageController.text;
    String heightText = _heightController.text;
    String weightText = _weightController.text;

    setState (() {
      //Check if all fields are filled
      if(ageText.isEmpty || heightText.isEmpty || weightText.isEmpty) {
        _resultMessage = "Please fill in all of the fields";
        _resultColor = Colors.red;
        return;
      }

      //Convert data to numbers
      double? age = double.tryParse(ageText);
      double? height = double.tryParse(heightText);
      double? weight = double.tryParse(weightText);

      //Validate converted data
      if (age == null || height == null || weight == null || 
          age <= 0 || height <= 0 || weight <= 0) {
            _resultMessage = "Please enter valid numbers";
            _resultColor = Colors.red;
            return;
      }

      //Calculate BMI
      double heightInMeters = height/100;
      double bmi = weight / (heightInMeters*heightInMeters);
      String category = "";

      if (bmi < 18.5) {
        category = "Underweight";
        _resultColor = Colors.blueAccent;
      } else if (bmi < 25) {
        category = "Normal";
        _resultColor = Colors.green;
      } else if (bmi < 30) {
        category = "Overweight";
        _resultColor = Colors.deepOrange;
      } else {
        category = "Obesity";
        _resultColor = Colors.red;
      }

      //Calculate BFP
      int sexModifier = _selectedGender == "M" ? 1:0;
      double bfp = (1.20 * bmi) + (0.23 * age) - (10.8 * sexModifier) - 5.4;

      //Display
      _resultMessage = "BMI: ${bmi.toStringAsFixed(2)} ($category)\n"
                       "Body Fat: ${bfp.toStringAsFixed(1)}%";
    });
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width - 50;

    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: Column(
        children: [
          DropdownMenu<String>(
              width: width,
              initialSelection: _selectedGender,
              label: const Text("Gender"),
              leadingIcon: const Icon(Icons.wc, color: Colors.deepPurple),
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(), 
                filled: false,
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
            decoration: InputDecoration(
              hintText: "Input your age",
              labelText: "Age",
              suffixText: "(years)",
              prefixIcon: Icon(Icons.person, color: Colors.deepPurple,),
              border: OutlineInputBorder(),
            )
          ),
          const SizedBox(height: 10.0),

          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Input your height",
              labelText: "Height",
              suffixText: "(cm)",
              prefixIcon: Icon(Icons.height, color: Colors.deepPurple,),
              border: OutlineInputBorder(),
            )
          ),
          const SizedBox(height: 10.0),

          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Input your weight",
              labelText: "Weight",
              suffixText: "(kg)",
              prefixIcon: Icon(Icons.scale, color: Colors.deepPurple,),
              border: OutlineInputBorder(),
            )
          ),
          const SizedBox(height: 10.0),

          ElevatedButton(
            onPressed: _calculateBMI, 
            child: Text("Calculate")
            ),
          const SizedBox(height: 30.0),

          Text(
              _resultMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _resultColor,
              ),
            ),
        ],
      )
    );
  }
}
