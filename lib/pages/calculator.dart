// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Plastic Impact Calculator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const CalculatorPage(),
//     );
//   }
// }

// class CalculatorPage extends StatefulWidget {
//   const CalculatorPage({super.key});

//   @override
//   State<CalculatorPage> createState() => _CalculatorPageState();
// }

// class _CalculatorPageState extends State<CalculatorPage> {
//   final _amountController = TextEditingController();
//   String _result = '';

//   void _calculateImpact() {
//     // Retrieve the amount of plastic from the input
//     final amount = double.tryParse(_amountController.text) ?? 0;

//     // Simple impact calculation (example values)
//     // For more accurate calculations, you would use specific metrics or formulas
//     final carbonFootprint = amount * 2.5; // Example: 2.5 kg CO2 per kg of plastic
//     final energySaved = amount * 3.0; // Example: 3 kWh per kg of plastic recycled

//     setState(() {
//       _result = 'Impact:\n'
//           '- Carbon Footprint: ${carbonFootprint.toStringAsFixed(2)} kg CO2\n'
//           '- Energy Saved (if recycled): ${energySaved.toStringAsFixed(2)} kWh';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plastic Impact Calculator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _amountController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: 'Amount of Plastic (kg)',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _calculateImpact,
//               child: const Text('Calculate Impact'),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               _result,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Degradation Calculators'),
        backgroundColor: Colors.pink[200], // Pastel pink
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNavigationButton(
              context, 'Bottle Calculator', const BottleCalculator()),
          const SizedBox(height: 16.0), // Add spacing between buttons
          _buildNavigationButton(
              context, 'Polybag Calculator', const PolybagCalculator()),
          const SizedBox(height: 16.0), // Add spacing between buttons
          _buildNavigationButton(context, 'Vegetable Waste Calculator',
              const VegetableWasteCalculator()),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(
      BuildContext context, String label, Widget page) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 8.0), // Margin around each button
      decoration: BoxDecoration(
        color: Colors.pink[50], // Pastel color for container
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.pink[100]!.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color.fromARGB(255, 248, 187, 225), // Button color
          padding: const EdgeInsets.symmetric(
              vertical: 20.0, horizontal: 16.0), // Button padding
          textStyle: const TextStyle(fontSize: 18), // Button text size
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Color.fromARGB(255, 173, 20, 153), // Button text color
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class BottleCalculator extends StatefulWidget {
  const BottleCalculator({super.key});

  @override
  _BottleCalculatorState createState() => _BottleCalculatorState();
}

class _BottleCalculatorState extends State<BottleCalculator> {
  final _controllerBottle = TextEditingController();
  String _result = '';
  String _reason = '';

  final double _bottleDegradationTime50ml = 50;
  final double _bottleDegradationTime1L = 450;

  String _selectedBottleSize = '50ml';

  void calc() {
    final int bottleCount = int.tryParse(_controllerBottle.text) ?? 0;

    final double bottleDegradationTime = _selectedBottleSize == '50ml'
        ? _bottleDegradationTime50ml
        : _bottleDegradationTime1L;

    final double totalBottleTime = bottleCount * bottleDegradationTime;

    setState(() {
      _result =
          'Total Degradation Time for Bottles: ${totalBottleTime.toStringAsFixed(2)} years';
      _reason = _selectedBottleSize == '50ml'
          ? '50ml bottles, primarily made from polyethylene terephthalate (PET), degrade very slowly due to the stable chemical structure of PET. PET is a polymer composed of repeating units of ethylene glycol and terephthalic acid, which are resistant to environmental degradation. The process of photodegradation, where UV rays break down the polymer chains, is very slow, leading to a degradation time of up to 50 years.'
          : '1-litre bottles, also made from PET, take up to 450 years to degrade. The larger volume of plastic and thicker material means a greater amount of PET to break down. The chemical stability of PET, combined with its resistance to microbial degradation, prolongs its presence in the environment. During degradation, PET undergoes photo-oxidation and hydrolysis, breaking down into smaller fragments over centuries, but not completely biodegrading.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottle Calculator'),
        backgroundColor: Colors.pink[200], // Pastel pink
      ),
      body: Container(
        color: Colors.pink[50],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose Bottle Size:',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[700])),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('50ml Bottle',
                        style:
                            TextStyle(fontSize: 20, color: Colors.pink[600])),
                    value: '50ml',
                    groupValue: _selectedBottleSize,
                    onChanged: (value) {
                      setState(() {
                        _selectedBottleSize = value!;
                      });
                    },
                    activeColor: Colors.pink[300],
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('1 Litre Bottle',
                        style:
                            TextStyle(fontSize: 20, color: Colors.pink[600])),
                    value: '1L',
                    groupValue: _selectedBottleSize,
                    onChanged: (value) {
                      setState(() {
                        _selectedBottleSize = value!;
                      });
                    },
                    activeColor: Colors.pink[300],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            _buildTextField(
              controller: _controllerBottle,
              label: 'Number of Bottles',
              color: Colors.pink[100]!,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: calc,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[300], // Button color
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0), // Button height
                textStyle: const TextStyle(fontSize: 18), // Button text size
              ),
              child: const Text('Calculate Degradation Time'),
            ),
            const SizedBox(height: 20.0),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Text(
              _reason,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required Color color,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: color,
        labelStyle: TextStyle(fontSize: 20),
      ),
      style: const TextStyle(fontSize: 20),
    );
  }
}

class PolybagCalculator extends StatefulWidget {
  const PolybagCalculator({super.key});

  @override
  _PolybagCalculatorState createState() => _PolybagCalculatorState();
}

class _PolybagCalculatorState extends State<PolybagCalculator> {
  final _controllerPolybag = TextEditingController();
  String _result = '';
  String _reason = '';

  final double _polybagDegradationTime = 1000;

  void calc() {
    final int polybagCount = int.tryParse(_controllerPolybag.text) ?? 0;
    final double totalPolybagTime = polybagCount * _polybagDegradationTime;

    setState(() {
      _result =
          'Total Degradation Time for Polybags: ${totalPolybagTime.toStringAsFixed(2)} years';
      _reason =
          'Polybags are primarily made from low-density polyethylene (LDPE) or linear low-density polyethylene (LLDPE), both of which are highly resistant to chemical breakdown. These plastics are long-chain polymers composed of ethylene units. The degradation process involves the slow oxidation of the polymer chains by UV radiation, which causes the material to become brittle and fragment into microplastics over approximately 1000 years. The chemical stability and low reactivity of LDPE and LLDPE contribute to their prolonged environmental presence.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polybag Calculator'),
        backgroundColor: Colors.lime[200], // Pastel lime
      ),
      body: Container(
        color: Colors.lime[50],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: _controllerPolybag,
              label: 'Number of Polybags',
              color: Colors.lime[100]!,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: calc,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lime[300], // Button color
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0), // Button height
                textStyle: const TextStyle(fontSize: 18), // Button text size
              ),
              child: const Text('Calculate Degradation Time'),
            ),
            const SizedBox(height: 20.0),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Text(
              _reason,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required Color color,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: color,
        labelStyle: TextStyle(fontSize: 20),
      ),
      style: const TextStyle(fontSize: 20),
    );
  }
}

class VegetableWasteCalculator extends StatefulWidget {
  const VegetableWasteCalculator({super.key});

  @override
  _VegetableWasteCalculatorState createState() =>
      _VegetableWasteCalculatorState();
}

class _VegetableWasteCalculatorState extends State<VegetableWasteCalculator> {
  final _controllerVegetableWaste = TextEditingController();
  String _result = '';
  String _reason = '';

  final double _vegetableWasteDegradationTime =
      1; // Vegetable waste degrades in a year

  void calc() {
    final int vegetableWasteCount =
        int.tryParse(_controllerVegetableWaste.text) ?? 0;
    final double totalVegetableWasteTime =
        vegetableWasteCount * _vegetableWasteDegradationTime;

    setState(() {
      _result =
          'Total Degradation Time for Vegetable Waste: ${totalVegetableWasteTime.toStringAsFixed(2)} years';
      _reason =
          'Vegetable waste, which includes food scraps and peels, generally decomposes quickly due to its organic nature. The degradation time for vegetable waste is typically around 1 year. This relatively short degradation period is due to the high moisture content and organic compounds that support microbial activity, leading to faster breakdown and composting of the waste.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vegetable Waste Calculator'),
        backgroundColor: Colors.lime[200], // Pastel lime
      ),
      body: Container(
        color: Colors.lime[50],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: _controllerVegetableWaste,
              label: 'Number of Vegetable Waste Items',
              color: Colors.lime[100]!,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: calc,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lime[300], // Button color
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0), // Button height
                textStyle: const TextStyle(fontSize: 18), // Button text size
              ),
              child: const Text('Calculate Degradation Time'),
            ),
            const SizedBox(height: 20.0),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Text(
              _reason,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required Color color,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: color,
        labelStyle: TextStyle(fontSize: 20),
      ),
      style: const TextStyle(fontSize: 20),
    );
  }
}
