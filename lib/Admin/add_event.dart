import 'dart:async';
import 'dart:io';
import 'package:plastic_eliminator/services/database.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plastic_eliminator/Admin/home_admin.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  TextEditingController rulesController = TextEditingController();
  bool _isLoading = false;

  String eventDate = '';
  String eventTime = '';

  Future<void> getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        eventDate = "${selectedDate.toLocal()}".split(' ')[0]; // Format as YYYY-MM-DD
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        final now = DateTime.now();
        final dateTime = DateTime(now.year, now.month, now.day,
            selectedTime.hour, selectedTime.minute);
        eventTime = "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}"; // Format as HH:MM AM/PM
      });
    }
  }

  Future<void> uploadItem() async {
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
          "Date": eventDate,
          "Time": eventTime,
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
            locationController.clear();
            descriptionController.clear();
            rewardController.clear();
            rulesController.clear();
            eventDate = '';
            eventTime = '';
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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImagePicker(),
            SizedBox(height: 20),
            _buildTextField('Event name', nameController),
            SizedBox(height: 20),
            _buildDateTimeField('Event date (YYYY-MM-DD)', _selectDate, eventDate),
            SizedBox(height: 20),
            _buildDateTimeField('Event time (HH:MM AM/PM)', _selectTime, eventTime),
            SizedBox(height: 20),
            _buildTextField('Event location', locationController),
            SizedBox(height: 20),
            _buildTextField('Event description', descriptionController),
            SizedBox(height: 20),
            _buildTextField('Event reward', rewardController),
            SizedBox(height: 20),
            _buildTextField('Event rules', rulesController),
            SizedBox(height: 20),
            Text(
              'Event month',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            _buildDropdown(),
            SizedBox(height: 20),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
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
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.camera_alt_outlined, size: 40),
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
                      borderRadius: BorderRadius.circular(8),
                    ),
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
      ],
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
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(color: Colors.black.withOpacity(0.3)),
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

  Widget _buildDateTimeField(String label, VoidCallback onTap, String value) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(color: Colors.black.withOpacity(0.3)),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              hintText: value.isEmpty ? 'Select $label' : value,
              suffixIcon: Icon(Icons.calendar_today),
              border: InputBorder.none,
            ),
            controller: TextEditingController(text: value),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(color: Colors.black.withOpacity(0.3)),
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
          hint: Text('Select month'),
          iconSize: 36,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          value: value,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: uploadItem,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        ),
        child: _isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                'Add Event',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.teal),
              ),
      ),
    );
  }
}
