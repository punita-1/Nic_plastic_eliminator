import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plastic Impact Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _amountController = TextEditingController();
  String _result = '';

  void _calculateImpact() {
    // Retrieve the amount of plastic from the input
    final amount = double.tryParse(_amountController.text) ?? 0;

    // Simple impact calculation (example values)
    // For more accurate calculations, you would use specific metrics or formulas
    final carbonFootprint = amount * 2.5; // Example: 2.5 kg CO2 per kg of plastic
    final energySaved = amount * 3.0; // Example: 3 kWh per kg of plastic recycled

    setState(() {
      _result = 'Impact:\n'
          '- Carbon Footprint: ${carbonFootprint.toStringAsFixed(2)} kg CO2\n'
          '- Energy Saved (if recycled): ${energySaved.toStringAsFixed(2)} kWh';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plastic Impact Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount of Plastic (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateImpact,
              child: const Text('Calculate Impact'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
