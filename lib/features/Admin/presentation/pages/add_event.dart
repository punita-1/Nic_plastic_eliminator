import 'dart:async';
import 'dart:io';
import 'package:plastic_eliminator/data/datasources/database.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plastic_eliminator/features/Admin/presentation/pages/home_admin.dart';

/// A stateful widget that allows the admin to add new events.
///
/// This widget provides functionality to pick an image, select event
/// date and time, and upload the event details to Firebase storage.
class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  // Image picker instance for selecting images from the gallery.
  final ImagePicker _picker = ImagePicker();

  // Stores the selected image file.
  File? selectedImage;

  // Controllers for various input fields.
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  TextEditingController rulesController = TextEditingController();
  TextEditingController registrationLinkController = TextEditingController();

  // Loading state to indicate when the event is being uploaded.
  bool _isLoading = false;

  // Strings to store selected event date and time.
  String eventDate = '';
  String eventTime = '';

  /// Opens the image picker to allow the user to select an image from the gallery.
  Future<void> getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  /// Opens the date picker to allow the user to select an event date.
  /// The selected date is stored in the [eventDate] variable.
  Future<void> _selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        eventDate =
            "${selectedDate.toLocal()}".split(' ')[0]; // Format as YYYY-MM-DD
      });
    }
  }

  /// Opens the time picker to allow the user to select an event time.
  /// The selected time is stored in the [eventTime] variable.
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
        eventTime =
            "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}"; // Format as HH:MM AM/PM
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

        // Upload the image and get the download URL
        final UploadTask uploadTask =
            firebaseStorageRef.putFile(selectedImage!);

        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          print(
              'Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
        });

        final TaskSnapshot taskSnapshot = await uploadTask;
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        print('Download URL: $downloadUrl');

        // Prepare event data
        final Map<String, dynamic> event = {
          "Name": nameController.text,
          "Date": eventDate,
          "Time": eventTime,
          "Location": locationController.text,
          "Description": descriptionController.text,
          "Reward": rewardController.text,
          "Rules": rulesController.text,
          "RegistrationLink": registrationLinkController.text,
          "Image": downloadUrl,
        };

        // Save event data to the database
        await DatabaseMethods().addEvent(event, value!);

        // Clear input fields and reset state
        setState(() {
          _isLoading = false;
          selectedImage = null;
          nameController.clear();
          locationController.clear();
          descriptionController.clear();
          rewardController.clear();
          rulesController.clear();
          registrationLinkController.clear();
          eventDate = '';
          eventTime = '';
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Event added successfully!',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to add event: ${e.toString()}',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      }
    } else {
      // Handle case where no image is selected or name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select an image and provide event name.',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );
    }
  }

  // Stores the selected event month from the dropdown.
  String? value;

  // List of available event month options.
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeAdmin()));
          },
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
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
            _buildDateTimeField(
                'Event date (YYYY-MM-DD)', _selectDate, eventDate),
            SizedBox(height: 20),
            _buildDateTimeField(
                'Event time (HH:MM AM/PM)', _selectTime, eventTime),
            SizedBox(height: 20),
            _buildTextField('Event location', locationController),
            SizedBox(height: 20),
            _buildTextField('Event description', descriptionController),
            SizedBox(height: 20),
            _buildTextField('Event reward', rewardController),
            SizedBox(height: 20),
            _buildTextField('Event rules', rulesController),
            SizedBox(height: 20),
            _buildTextField('Registration link', registrationLinkController),
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

  /// Builds the image picker widget.
  ///
  /// This widget allows the user to upload an image for the event.
  /// If an image is selected, it is displayed in a preview box.
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

  /// Builds a text field widget with the given [label] and [controller].
  ///
  /// This widget is used for various input fields such as event name, location,
  /// description, reward, and rules.
  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 15),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ],
    );
  }

  /// Builds a date/time picker widget with the given [label], [onTap] function,
  /// and [value] string.
  ///
  /// This widget is used for selecting the event date and time.
  Widget _buildDateTimeField(
      String label, Future<void> Function() onTap, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 15),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextField(
              controller: TextEditingController(text: value),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                suffixIcon: Icon(Icons.calendar_today_outlined),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the dropdown widget for selecting the event month.
  ///
  /// This widget provides a dropdown menu to select the month of the event.
  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text('Select month'),
          items: categoryItems.map((String month) {
            return DropdownMenuItem<String>(
              value: month,
              child: Text(month),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
    );
  }

  /// Builds the submit button widget.
  ///
  /// This widget displays a button that allows the user to submit the event
  /// details. While the event is being uploaded, a loading spinner is shown.
  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _isLoading ? null : uploadItem,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          textStyle: TextStyle(fontSize: 18),
        ),
        child: _isLoading
            ? CircularProgressIndicator(color: Colors.teal)
            : Text(
                'Add Event',
                style: TextStyle(color: Colors.teal),
              ),
      ),
    );
  }
}
