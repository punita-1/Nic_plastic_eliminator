import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminLearningPage extends StatefulWidget {
  @override
  _AdminLearningPageState createState() => _AdminLearningPageState();
}

class _AdminLearningPageState extends State<AdminLearningPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();

  bool _isSaving = false;

  /// Function to save content to Firestore
  Future<void> _saveContent() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || _pointsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final List<String> points = _pointsController.text
          .split('\n')
          .where((point) => point.isNotEmpty)
          .toList();

      await FirebaseFirestore.instance.collection('learningContent').add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'points': points,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Content added successfully')),
      );

      // Clear the fields after saving
      _titleController.clear();
      _descriptionController.clear();
      _pointsController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save content: $e')),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Panel - Add Learning Content'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title Input
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),

              // Description Input
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),

              // Points Input
              TextField(
                controller: _pointsController,
                decoration: InputDecoration(
                  labelText: 'Points (separate each point by pressing Enter)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 6,
              ),
              SizedBox(height: 16.0),

              // Save Button
              ElevatedButton(
                onPressed: _isSaving ? null : _saveContent,
                child: _isSaving
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text('Save Content'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
