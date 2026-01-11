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
        appBar: AppBar(title: Text("BMIiii Calculator"),
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

class _ComputeBMI extends State{
  String _selectedGender = "M";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: Column(
        children: [
          Row (
            children: [
              const Icon(Icons.wc, color: Colors.deepPurple),
              const SizedBox(width: 15),
              const Text("Gender: "),
              const SizedBox(width: 20),
              
              DropdownButton<String>(
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: "M", child: Center(child: Text("Male"))),
                  DropdownMenuItem(value: "F", child: Center(child: Text("Female"))),
                ],
                value: _selectedGender,
                onChanged: (val) => setState(() => _selectedGender = val!),
              ),
            ],
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Input your age",
              labelText: "Age",
              prefixIcon: Icon(Icons.person, color: Colors.deepPurple,)
            )
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Input your height",
              labelText: "Height",
              suffixText: "(cm)",
              prefixIcon: Icon(Icons.height, color: Colors.deepPurple,)
            )
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Input your weight",
              labelText: "Weight",
              suffixText: "(kg)",
              prefixIcon: Icon(Icons.scale, color: Colors.deepPurple,)
            )
          ),
          ElevatedButton(
            onPressed: (){}, 
            child: Text("Calculate")
            ),
            Text("")
        ],
      )
    );
  }
}
