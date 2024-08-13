import 'package:flutter/material.dart';
import 'package:plastic_eliminator/navigation/bottomnav.dart';
import 'package:plastic_eliminator/features/Home/events_pages/event_details.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final List<Map<String, String>> months = [
    {'name': 'January', 'specialDay': 'Environment Day'},
    {'name': 'February', 'specialDay': 'None'},
    {'name': 'March', 'specialDay': 'Tree Day'},
    {'name': 'April', 'specialDay': 'None'},
    {'name': 'May', 'specialDay': 'Recycling Day'},
    {'name': 'June', 'specialDay': 'None'},
    {'name': 'July', 'specialDay': 'None'},
    {'name': 'August', 'specialDay': 'Earth Day'},
    {'name': 'September', 'specialDay': 'None'},
    {'name': 'October', 'specialDay': 'Green Day'},
    {'name': 'November', 'specialDay': 'None'},
    {'name': 'December', 'specialDay': 'Clean Air Day'},
  ];

  bool isMonthClickable(int monthIndex) {
    DateTime now = DateTime.now();
    return monthIndex >= now.month - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Categories',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: ListView.builder(
        itemCount: months.length,
        itemBuilder: (context, index) {
          bool clickable = isMonthClickable(index);
          return Column(
            children: [
              Container(
                child: ListTile(
                  title: Text(
                    months[index]['name']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: clickable ? Colors.black : Colors.grey[600],
                    ),
                  ),
                  subtitle: Text(
                    months[index]['specialDay']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: clickable ? Colors.black : Colors.grey[600],
                    ),
                  ),
                  onTap: clickable
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetails(
                                month: months[index]['name']!,
                              ),
                            ),
                          );
                        }
                      : null,
                  enabled:
                      clickable, // This will visually show the item as disabled
                ),
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}
