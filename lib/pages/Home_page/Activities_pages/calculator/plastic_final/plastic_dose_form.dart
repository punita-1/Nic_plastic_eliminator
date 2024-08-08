import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plastic_eliminator/pages/Home_page/Activities_pages/calculator/plastic_final/calculate_impact.dart';

class PlasticUsageForm extends StatefulWidget {
  @override
  _PlasticUsageFormState createState() => _PlasticUsageFormState();
}

class _PlasticUsageFormState extends State<PlasticUsageForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _plasticBagsController = TextEditingController();
  final TextEditingController _plasticBottlesController =
      TextEditingController();
  final TextEditingController _plasticItemsController = TextEditingController();
  final TextEditingController _disposableItemsController =
      TextEditingController();

  @override
  void dispose() {
    _plasticBagsController.dispose();
    _plasticBottlesController.dispose();
    _plasticItemsController.dispose();
    _disposableItemsController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final plasticBags = int.tryParse(_plasticBagsController.text) ?? 0;
      final plasticBottles = int.tryParse(_plasticBottlesController.text) ?? 0;
      final plasticItems = double.tryParse(_plasticItemsController.text) ?? 0.0;
      final disposableItems =
          int.tryParse(_disposableItemsController.text) ?? 0;

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(userId);

        await userDoc.set({
          'plasticBags': plasticBags,
          'plasticBottles': plasticBottles,
          'plasticItems': plasticItems,
          'disposableItems': disposableItems,
          'timestamp': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data submitted successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not logged in!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plastic Usage Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _plasticBagsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of plastic bags used daily',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of plastic bags';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _plasticBottlesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of plastic bottles used daily',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of plastic bottles';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _plasticItemsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Kg of plastic items thrown out daily',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the kg of plastic items';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _disposableItemsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of disposable items used monthly',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of disposable items';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlasticImpactScreen()));
                },
                child: Text(
                  'Go to Impact Calculate Page',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
