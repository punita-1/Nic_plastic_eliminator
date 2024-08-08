import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditPlasticDetailsScreen extends StatefulWidget {
  @override
  _EditPlasticDetailsScreenState createState() => _EditPlasticDetailsScreenState();
}

class _EditPlasticDetailsScreenState extends State<EditPlasticDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  int plasticBags = 0;
  int plasticBottles = 0;
  double plasticItems = 0.0;
  int disposableItems = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlasticUsageDetails();
  }

  Future<void> _fetchPlasticUsageDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final snapshot = await userDoc.get();

      if (snapshot.exists) {
        setState(() {
          plasticBags = snapshot['plasticBags'] ?? 0;
          plasticBottles = snapshot['plasticBottles'] ?? 0;
          plasticItems = snapshot['plasticItems'] ?? 0.0;
          disposableItems = snapshot['disposableItems'] ?? 0;
          isLoading = false;
        });
      }
    }
  }

  Future<void> _savePlasticUsageDetails() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
        await userDoc.update({
          'plasticBags': plasticBags,
          'plasticBottles': plasticBottles,
          'plasticItems': plasticItems,
          'disposableItems': disposableItems,
        });
        Navigator.of(context).pop(true); // Return true to indicate success
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Plastic Details'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: plasticBags.toString(),
                      decoration: InputDecoration(labelText: 'Plastic Bags'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of plastic bags';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        plasticBags = int.parse(value!);
                      },
                    ),
                    TextFormField(
                      initialValue: plasticBottles.toString(),
                      decoration: InputDecoration(labelText: 'Plastic Bottles'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of plastic bottles';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        plasticBottles = int.parse(value!);
                      },
                    ),
                    TextFormField(
                      initialValue: plasticItems.toString(),
                      decoration: InputDecoration(labelText: 'Plastic Items (kg)'),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the weight of plastic items';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        plasticItems = double.parse(value!);
                      },
                    ),
                    TextFormField(
                      initialValue: disposableItems.toString(),
                      decoration: InputDecoration(labelText: 'Disposable Items'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of disposable items';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        disposableItems = int.parse(value!);
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _savePlasticUsageDetails,
                      child: Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
