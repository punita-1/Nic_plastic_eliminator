// import 'package:flutter/material.dart';
// import 'package:plastic_eliminator/pages/event_details.dart';

// class Events extends StatefulWidget {
//   const Events({super.key});

//   @override
//   State<Events> createState() => _EventsState();
// }

// class _EventsState extends State<Events> {
//   final List<Map<String, String>> months = [
//     {'name': 'January', 'specialDay': 'Environment Day'},
//     {'name': 'February', 'specialDay': ''},
//     {'name': 'March', 'specialDay': 'Tree Day'},
//     {'name': 'April', 'specialDay': ''},
//     {'name': 'May', 'specialDay': 'Recycling Day'},
//     {'name': 'June', 'specialDay': ''},
//     {'name': 'July', 'specialDay': ''},
//     {'name': 'August', 'specialDay': 'Earth Day'},
//     {'name': 'September', 'specialDay': ''},
//     {'name': 'October', 'specialDay': 'Green Day'},
//     {'name': 'November', 'specialDay': ''},
//     {'name': 'December', 'specialDay': 'Clean Air Day'},
//   ];

//   bool isMonthClickable(int monthIndex) {
//     DateTime now = DateTime.now();
//     return monthIndex >= now.month - 1;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event Categories'),
//       ),
//       body: ListView.builder(
//         itemCount: months.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(months[index]['name']!),
//             subtitle: Text(months[index]['specialDay']!),
//             onTap: isMonthClickable(index)
//                 ? () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EventDetails(),
//                       ),
//                     );
//                   }
//                 : null,
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/event_details.dart';
// import 'package:plastic_eliminator/pages/event_details.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final List<Map<String, String>> months = [
    {'name': 'January', 'specialDay': 'Environment Day'},
    {'name': 'February', 'specialDay': ''},
    {'name': 'March', 'specialDay': 'Tree Day'},
    {'name': 'April', 'specialDay': ''},
    {'name': 'May', 'specialDay': 'Recycling Day'},
    {'name': 'June', 'specialDay': ''},
    {'name': 'July', 'specialDay': ''},
    {'name': 'August', 'specialDay': 'Earth Day'},
    {'name': 'September', 'specialDay': ''},
    {'name': 'October', 'specialDay': 'Green Day'},
    {'name': 'November', 'specialDay': ''},
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
        title: Text('Event Categories'),
      ),
      body: ListView.builder(
        itemCount: months.length,
        itemBuilder: (context, index) {
          bool clickable = isMonthClickable(index);
          return Container(
            child: ListTile(
              title: Text(
                months[index]['name']!,
                style: TextStyle(
                  color: clickable ? Colors.black : Colors.grey[300],
                ),
              ),
              subtitle: Text(
                months[index]['specialDay']!,
                style: TextStyle(
                  color: clickable ? Colors.black : Colors.grey[300],
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
          );
        },
      ),
    );
  }
}
