import 'dart:async';
import 'dart:io';
import 'package:plastic_eliminator/services/database.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plastic_eliminator/Admin/home_admin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  TextEditingController rulesController = TextEditingController();
  bool _isLoading = false;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null && nameController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        String addId = randomAlphaNumeric(10);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child("eventImages").child(addId);

        final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
        var downloadUrl = await (await task).ref.getDownloadURL();

        Map<String, dynamic> event = {
          "Name": nameController.text,
          "Date": dateController.text,
          "Time": timeController.text,
          "Location": locationController.text,
          "Description": descriptionController.text,
          "Reward": rewardController.text,
          "Rules": rulesController.text,
          "Image": downloadUrl,
        };

        await DatabaseMethods().addevents(event, value!).then((value) {
          setState(() {
            _isLoading = false;
            selectedImage = null;
            nameController.clear();
            dateController.clear();
            timeController.clear();
            locationController.clear();
            descriptionController.clear();
            rewardController.clear();
            rulesController.clear();
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            'Event added successfully!',
            style: TextStyle(fontSize: 20.0),
          )));
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Failed to add event: $e',
          style: TextStyle(fontSize: 20.0),
        )));
      }
    }
  }

  String? value;
  final List<String> categoryItems = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Events'),
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeAdmin()));
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 25, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload event banner image',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15),
              selectedImage == null
                  ? GestureDetector(
                      onTap: getImage,
                      child: Center(
                          child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.camera_alt_outlined),
                      )),
                    )
                  : Center(
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 15),
              _buildTextField('Event name', nameController),
              SizedBox(height: 15),
              _buildTextField('Event date (YYYY-MM-DD)', dateController),
              SizedBox(height: 15),
              _buildTextField('Event time (HH:MM AM/PM)', timeController),
              SizedBox(height: 15),
              _buildTextField('Event location', locationController),
              SizedBox(height: 15),
              _buildTextField('Event description', descriptionController),
              SizedBox(height: 15),
              _buildTextField('Event reward', rewardController),
              SizedBox(height: 15),
              _buildTextField('Event rules', rulesController),
              SizedBox(height: 15),
              Text(
                'Event month',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: categoryItems
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      this.value = value;
                    }),
                    dropdownColor: Colors.white,
                    hint: Text('Select month'),
                    iconSize: 36,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: uploadItem,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Adjust this value for less curvature
                  ),
                  backgroundColor: Colors.white, // Background color
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.grey,
                        ),
                      )
                    : Text(
                        'Add Event',
                        style: TextStyle(color: Colors.grey),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter $label',
            ),
          ),
        ),
      ],
    );
  }
}
