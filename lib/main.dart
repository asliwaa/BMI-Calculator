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
  String _selectedGender = "M";

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
            onPressed: (){}, 
            child: Text("Calculate")
            ),
        ],
      )
    );
  }
}
