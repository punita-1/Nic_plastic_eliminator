import 'package:flutter/material.dart';

class RegisterNow extends StatelessWidget {
  final Map<String, String> event;

  const RegisterNow({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register for ${event['title']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Event: ${event['title']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Date: ${event['date']}'),
            SizedBox(height: 10),
            Text('Time: ${event['time']}'),
            SizedBox(height: 10),
            Text('Location: ${event['location']}'),
            SizedBox(height: 10),
            Text('Description: ${event['description']}'),
            SizedBox(height: 10),
            Text('Reward: ${event['reward']}'),
            SizedBox(height: 10),
            Text('Rules: ${event['rules']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Register the user for the event
                // TODO: Add registration logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You have registered for ${event['title']}')),
                );
                Navigator.pop(context);
              },
              child: Text('Register Now'),
            ),
          ],
        ),
      ),
    );
  }
}
