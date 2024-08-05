import 'package:flutter/material.dart';

class ChallengeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.teal[100]!,
        title: Text(
          'Challenges',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ChallengeBox(
              title: 'Daily Tasks',
              color: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TasksPage(
                      title: 'Daily Tasks',
                      tasks: generateTasks('daily'),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            ChallengeBox(
              title: 'Weekly Tasks',
              color: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TasksPage(
                      title: 'Weekly Tasks',
                      tasks: generateTasks('weekly'),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            ChallengeBox(
              title: 'Monthly Tasks',
              color: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TasksPage(
                      title: 'Monthly Tasks',
                      tasks: generateTasks('monthly'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeBox extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;

  ChallengeBox({required this.title, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class TasksPage extends StatefulWidget {
  final String title;
  final List<String> tasks;

  TasksPage({required this.title, required this.tasks});

  @override
  _TasksPageState createState() => _TasksPageState();
}

// class _TasksPageState extends State<TasksPage> {
//   late List<bool> _taskCompletion;

//   @override
//   void initState() {
//     super.initState();
//     _taskCompletion = List<bool>.filled(widget.tasks.length, false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           widget.title,
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         // backgroundColor: Colors.green[100],
//       ),
//       body: ListView.builder(
//         itemCount: widget.tasks.length,
//         itemBuilder: (context, index) {
//           return Card(
//             color: getPastelColor(index),
//             margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//             child: ListTile(
//               leading: Checkbox(
//                 value: _taskCompletion[index],
//                 onChanged: (bool? value) {
//                   setState(() {
//                     _taskCompletion[index] = value ?? false;
//                   });
//                 },
//               ),
//               title: Text(widget.tasks[index]),
//               trailing: _taskCompletion[index]
//                   ? Icon(Icons.done, color: Colors.green)
//                   : null,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Color getPastelColor(int index) {
//     List<Color> pastelColors = [
//       Colors.white,
//       Colors.white,
//       Colors.white,
//       Colors.white,
//       Colors.white,
//       Colors.white,
//       Colors.white,
//       Colors.white,
//       Colors.white,
//       Colors.white,
//     ];
//     return pastelColors[index % pastelColors.length];
//   }
// }
class _TasksPageState extends State<TasksPage> {
  late List<bool> _taskCompletion;

  @override
  void initState() {
    super.initState();
    _taskCompletion = List<bool>.filled(widget.tasks.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // backgroundColor: Colors.green[100],
      ),
      body: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return Card(
            color: getPastelColor(index),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ListTile(
              leading: Checkbox(
                value: _taskCompletion[index],
                onChanged: (bool? value) {
                  setState(() {
                    _taskCompletion[index] = value ?? false;
                  });
                },
              ),
              title: Text(widget.tasks[index]),
              trailing: _taskCompletion[index]
                  ? Icon(Icons.done, color: Colors.green)
                  : null,
            ),
          );
        },
      ),
    );
  }

  Color getPastelColor(int index) {
    List<Color> pastelColors = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
    return pastelColors[index % pastelColors.length];
  }
}

List<String> generateTasks(String type) {
  switch (type) {
    case 'daily':
      return [
        'Say no to plastic bottles for a day',
        'Avoid using plastic bags',
        'Use a reusable coffee cup',
        'Refuse plastic straws',
        'Carry a cloth bag for shopping',
        'Use metal utensils instead of plastic',
        'Recycle household plastic waste',
        'Educate someone about plastic pollution',
        'Avoid buying plastic-packaged products',
        'Use a bamboo toothbrush'
      ];
    case 'weekly':
      return [
        'Collect plastic waste in your neighborhood',
        'Organize a plastic-free week at work',
        'Host a plastic-free dinner party',
        'Create a plastic-free kit for daily use',
        'Start a compost bin to reduce plastic waste',
        'Replace plastic food containers with glass or metal',
        'Write a blog about plastic pollution',
        'Support a local plastic-free initiative',
        'Create art from recycled plastic',
        'Conduct a plastic audit in your home'
      ];
    case 'monthly':
      return [
        'Participate in a local beach cleanup',
        'Advocate for plastic-free policies in your community',
        'Host a workshop on reducing plastic waste',
        'Join a plastic-free challenge group',
        'Switch to a plastic-free subscription service',
        'Donate to an organization fighting plastic pollution',
        'Conduct a plastic-free school project',
        'Volunteer with a plastic pollution NGO',
        'Plant trees to combat plastic pollution',
        'Create a monthly plastic reduction plan'
      ];
    default:
      return [];
  }
}
