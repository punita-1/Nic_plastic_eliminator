import 'package:flutter/material.dart';

class PlasticFootprintCalculator extends StatefulWidget {
  const PlasticFootprintCalculator({super.key});

  @override
  _PlasticFootprintCalculatorState createState() =>
      _PlasticFootprintCalculatorState();
}

class _PlasticFootprintCalculatorState
    extends State<PlasticFootprintCalculator> {
  final _controllerBags = TextEditingController();
  final _controllerBottles = TextEditingController();
  String _result = '';
  String _impact = '';

  void calcFootprint() {
    final int bags = int.tryParse(_controllerBags.text) ?? 0;
    final int bottles = int.tryParse(_controllerBottles.text) ?? 0;

    final double bagFootprint = bags * 0.5; // kg of CO2 per bag
    final double bottleFootprint = bottles * 0.3; // kg of CO2 per bottle
    final double totalFootprint = bagFootprint + bottleFootprint;

    final double marineLifeImpact =
        (bags + bottles) * 0.1; // Impact on marine life
    final double ecosystemDamage =
        (bags + bottles) * 0.05; // Damage to ecosystems
    final double resourceLoss = (bags + bottles) * 0.2; // Loss of resources

    setState(() {
      _result =
          'Your total plastic footprint is ${totalFootprint.toStringAsFixed(2)} kg of CO2 equivalent.';

      _impact = 'Environmental Impact:\n'
          '- Marine Life: ${marineLifeImpact.toStringAsFixed(2)} units (This is like adding harmful plastic to the ocean, which can hurt sea animals)\n'
          '- Ecosystem Damage: ${ecosystemDamage.toStringAsFixed(2)} units (This is like disrupting natural areas where plants and animals live)\n'
          '- Resource Loss: ${resourceLoss.toStringAsFixed(2)} units (This is like wasting materials that could be used for other things)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calculate Your Plastic Footprint',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20.0),
              _buildTextField(
                controller: _controllerBags,
                label: 'Number of Plastic Bags Used Weekly',
                color: Colors.white,
              ),
              const SizedBox(height: 20.0),
              _buildTextField(
                controller: _controllerBottles,
                label: 'Number of Plastic Bottles Consumed Weekly',
                color: Colors.white,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: calcFootprint,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Calculate Footprint',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                _result,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Text(
                _impact,
                style: const TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            ],
          ),
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
