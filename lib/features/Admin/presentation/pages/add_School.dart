import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({Key? key}) : super(key: key);

  @override
  _AdminPanelPageState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _schoolCodeController = TextEditingController();
  final TextEditingController _activitiesController = TextEditingController();
  final TextEditingController _ngoInvolvedController = TextEditingController();
  final TextEditingController _clerkNameController = TextEditingController();
  final TextEditingController _ngoHeadOfSchoolController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _socialMediaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'School Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the school name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _schoolCodeController,
                decoration: InputDecoration(labelText: 'School Code'),
              ),
              TextFormField(
                controller: _activitiesController,
                decoration: InputDecoration(labelText: 'Activities Done by School'),
              ),
              TextFormField(
                controller: _ngoInvolvedController,
                decoration: InputDecoration(labelText: 'NGO Involved'),
              ),
              TextFormField(
                controller: _clerkNameController,
                decoration: InputDecoration(labelText: 'Clerk Name'),
              ),
              TextFormField(
                controller: _ngoHeadOfSchoolController,
                decoration: InputDecoration(labelText: 'NGO Head of School'),
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: _socialMediaController,
                decoration: InputDecoration(labelText: 'Social Media (JSON)'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addSchoolToFirestore();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addSchoolToFirestore() async {
    final Map<String, dynamic> socialMedia = _parseSocialMedia(_socialMediaController.text);

    await FirebaseFirestore.instance.collection('schools').add({
      'name': _nameController.text,
      'school_code': _schoolCodeController.text,
      'activities_done_by_school': _activitiesController.text,
      'ngo_involved': _ngoInvolvedController.text,
      'clerk_name': _clerkNameController.text,
      'ngo_head_of_school': _ngoHeadOfSchoolController.text,
      'phone_number': _phoneNumberController.text,
      'address': _addressController.text,
      'social_media': socialMedia,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('School details added successfully')),
    );

    // Clear the form fields
    _nameController.clear();
    _schoolCodeController.clear();
    _activitiesController.clear();
    _ngoInvolvedController.clear();
    _clerkNameController.clear();
    _ngoHeadOfSchoolController.clear();
    _phoneNumberController.clear();
    _addressController.clear();
    _socialMediaController.clear();
  }

  Map<String, dynamic> _parseSocialMedia(String json) {
    // Convert JSON string to Map
    try {
      return Map<String, dynamic>.from(jsonDecode(json));
    } catch (e) {
      return {};
    }
  }
}
