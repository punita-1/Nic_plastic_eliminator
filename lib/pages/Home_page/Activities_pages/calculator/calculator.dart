import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/calculator/plastic_final/plastic_dose_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Waste Degradation Calculator',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNavigationButton(
              context, 'Bottle Calculator', const BottleCalculator()),
          const SizedBox(height: 16.0),
          _buildNavigationButton(
              context, 'Polybag Calculator', const PolybagCalculator()),
          const SizedBox(height: 16.0),
          _buildNavigationButton(context, 'Vegetable Waste Calculator',
              const VegetableWasteCalculator()),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              // Navigate to PlasticDoseScreen with current user ID
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlasticUsageForm()),
                );
              } else {
                // Handle the case when the user is not signed in
              }
            },
            child: Text(
              'Track Plastic Dose',
              style: TextStyle(color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(
      BuildContext context, String label, Widget page) {
    return Container(
      margin: const EdgeInsets.only(top: 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.teal,
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
        centerTitle: true,
        title: Text(
          'Bottle Calculator',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Choose Bottle Size:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('50ml Bottle',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      value: '50ml',
                      groupValue: _selectedBottleSize,
                      onChanged: (value) {
                        setState(() {
                          _selectedBottleSize = value!;
                        });
                      },
                      activeColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('1 Litre Bottle',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      value: '1L',
                      groupValue: _selectedBottleSize,
                      onChanged: (value) {
                        setState(() {
                          _selectedBottleSize = value!;
                        });
                      },
                      activeColor: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              _buildTextField(
                controller: _controllerBottle,
                label: 'Number of Bottles',
                color: Colors.white,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: calc,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10), // Button height
                  textStyle: const TextStyle(fontSize: 18), // Button text size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust this value for less curve
                  ),
                ),
                child: const Text(
                  'Calculate Degradation Time',
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
                _reason,
                style: const TextStyle(fontSize: 18, color: Colors.teal),
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
        centerTitle: true,
        title: Text(
          'Polybag Calculator',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _controllerPolybag,
                label: 'Number of Polybags',
                color: Colors.white,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: calc,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10), // Button height
                  textStyle: const TextStyle(fontSize: 18), // Button text size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust this value for less curve
                  ),
                ),
                child: const Text(
                  'Calculate Degradation Time',
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
                _reason,
                style: const TextStyle(fontSize: 18, color: Colors.teal),
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

  final double _vegetableWasteDegradationTime = 0.5;

  void calc() {
    final int vegetableWasteCount =
        int.tryParse(_controllerVegetableWaste.text) ?? 0;
    final double totalVegetableWasteTime =
        vegetableWasteCount * _vegetableWasteDegradationTime;

    setState(() {
      _result =
          'Total Degradation Time for Vegetable Waste: ${totalVegetableWasteTime.toStringAsFixed(2)} years';
      _reason =
          'Vegetable waste is composed primarily of organic materials that are easily broken down by microorganisms. The degradation process involves the action of bacteria, fungi, and other decomposers that break down complex organic compounds into simpler substances. This process, known as biodegradation, is relatively quick compared to plastic degradation. Vegetable waste typically decomposes within 3 to 6 months, depending on environmental conditions such as temperature, moisture, and the presence of decomposing organisms.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Vegetable Waste Calculator',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _controllerVegetableWaste,
                label: 'Weight of Vegetable Waste (kg)',
                color: Colors.white,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: calc,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10), // Button height
                  textStyle: const TextStyle(fontSize: 18), // Button text size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust this value for less curve
                  ),
                ),
                child: const Text(
                  'Calculate Degradation Time',
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
                _reason,
                style: const TextStyle(fontSize: 18, color: Colors.teal),
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
