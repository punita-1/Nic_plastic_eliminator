import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double _rating = 3.0;
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  bool _feedbackSubmitted = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _feedbackSubmitted = true;
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Feedback Submitted'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Thank you for your feedback!'),
                SizedBox(height: 10),
                Icon(Icons.sentiment_satisfied, color: Colors.green, size: 50),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Rate Us',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                              size: 60,
                            );
                          case 1:
                            return Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.orange,
                              size: 60,
                            );
                          case 2:
                            return Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                              size: 60,
                            );
                          case 3:
                            return Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                              size: 60,
                            );
                          case 4:
                            return Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                              size: 60,
                            );
                          default:
                            return Container();
                        }
                      },
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Feedback Form',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Feedback',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _feedbackController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your feedback';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: _submitFeedback,
                            child: Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'FAQs',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  ExpansionTile(
                    title: Text('What is plastic pollution?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Plastic pollution involves the accumulation of plastic products in the environment that adversely affects wildlife, wildlife habitat, or humans.'),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text('How can we reduce plastic waste?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('We can reduce plastic waste by recycling, using reusable products, and avoiding single-use plastics.'),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text('What are the benefits of recycling?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Recycling helps to conserve resources, reduce pollution, and decrease energy consumption.'),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text('What are sustainable alternatives to plastic?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Sustainable alternatives to plastic include materials like glass, metal, and biodegradable plastics.'),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text('How can I get involved in plastic eradication?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('You can get involved by participating in local clean-up events, advocating for policy changes, and educating others about the impacts of plastic pollution.'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text('Email: contact@example.com', textAlign: TextAlign.center),
                  Text('Phone: +1234567890', textAlign: TextAlign.center),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}