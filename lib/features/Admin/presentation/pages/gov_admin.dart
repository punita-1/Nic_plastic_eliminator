import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class GovWorkAdminPanel extends StatefulWidget {
  @override
  _GovWorkAdminPanelState createState() => _GovWorkAdminPanelState();
}

class _GovWorkAdminPanelState extends State<GovWorkAdminPanel> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _smallDescriptionController = TextEditingController();
  final TextEditingController _largeDescriptionController = TextEditingController();
  DateTime? _selectedDate;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text('Add New Initiative'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _smallDescriptionController,
                decoration: InputDecoration(labelText: 'Small Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a small description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _largeDescriptionController,
                decoration: InputDecoration(labelText: 'Large Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a large description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Select Date'),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                },
                child: Text(
                  _selectedDate == null
                      ? 'Choose Date'
                      : _selectedDate!.toLocal().toString().split(' ')[0],
                ),
              ),
              SizedBox(height: 16.0),
              Text('Upload Image'),
              SizedBox(height: 8.0),
              _imageFile == null
                  ? ElevatedButton(
                      onPressed: () async {
                        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          setState(() {
                            _imageFile = File(pickedFile.path);
                          });
                        }
                      },
                      child: Text('Pick Image'),
                    )
                  : Image.file(_imageFile!),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await _uploadInitiative();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Initiative added successfully')),
                    );
                    _clearForm();
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

  Future<void> _uploadInitiative() async {
    final storageRef = FirebaseStorage.instance.ref().child('initiative_images/${DateTime.now().millisecondsSinceEpoch}.png');
    final uploadTask = storageRef.putFile(_imageFile!);
    final snapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();

    final firestore = FirebaseFirestore.instance;
    await firestore.collection('initiatives').add({
      'title': _titleController.text,
      'smallDescription': _smallDescriptionController.text,
      'largeDescription': _largeDescriptionController.text,
      'imageUrl': imageUrl,
      'date': _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : Timestamp.now(),
    });
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _smallDescriptionController.clear();
    _largeDescriptionController.clear();
    setState(() {
      _selectedDate = null;
      _imageFile = null;
    });
  }
}
