// // import 'package:flutter/material.dart';

// // class News extends StatefulWidget {
// //   const News({super.key});

// //   @override
// //   State<News> createState() => _NewsState();
// // }

// // class _NewsState extends State<News> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //   }
// // }
// import 'package:flutter/material.dart';

// class News extends StatefulWidget {
//   const News({super.key});

//   @override
//   State<News> createState() => _NewsState();
// }

// class _NewsState extends State<News> {
//   final List<Map<String, String>> newsArticles = [
//     {
//       'title': 'New Plastic Recycling Plant Opens',
//       'description':
//           'A new plastic recycling plant has opened in the city, aiming to reduce plastic waste.',
//       'url': 'https://example.com/news1',
//     },
//     {
//       'title': 'Innovative Plastic Alternatives',
//       'description':
//           'Researchers have developed innovative plastic alternatives that are biodegradable.',
//       'url': 'https://example.com/news2',
//     },
//     {
//       'title': 'Plastic Waste Management Strategies',
//       'description':
//           'Cities are adopting new strategies for managing plastic waste more effectively.',
//       'url': 'https://example.com/news3',
//     },
//     {
//       'title': 'Ocean Cleanup Efforts',
//       'description':
//           'New ocean cleanup efforts are being launched to tackle plastic pollution.',
//       'url': 'https://example.com/news4',
//     },
//     {
//       'title': 'Legislation on Single-Use Plastics',
//       'description':
//           'Governments are introducing legislation to ban single-use plastics.',
//       'url': 'https://example.com/news5',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plastic News'),
//       ),
//       body: ListView.builder(
//         itemCount: newsArticles.length,
//         itemBuilder: (context, index) {
//           final newsArticle = newsArticles[index];
//           return Card(
//             margin: const EdgeInsets.all(10),
//             child: ListTile(
//               title: Text(newsArticle['title']!),
//               subtitle: Text(newsArticle['description']!),
//               trailing: Icon(Icons.arrow_forward),
//               onTap: () {
//                 // Handle article tap
//                 // For simplicity, we'll just print the URL to the console
//                 print('Opening URL: ${newsArticle['url']}');
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<Map<String, String>> newsList = [
    {
      'title': 'Global Plastic Waste Reduction Initiative Launched',
      'description': 'In a major global effort to combat plastic waste, international leaders have launched the Global Plastic Waste Reduction Initiative. This initiative aims to cut down plastic production by 50% over the next decade and improve recycling processes worldwide. Governments and corporations are joining forces to implement new policies, enhance waste management systems, and support innovative recycling technologies.',
      'date': '2024-07-01',
    },
    {
      'title': 'New Biodegradable Plastics Show Promise',
      'description': 'Researchers have unveiled a new line of biodegradable plastics that decompose within months instead of centuries. These new materials are made from organic compounds and offer a viable alternative to traditional plastics. The development is expected to significantly reduce plastic pollution in landfills and oceans, contributing to a cleaner environment.',
      'date': '2024-07-03',
    },
    {
      'title': 'Community Plastic Cleanup Drives Make Significant Impact',
      'description': 'Local community cleanup drives have successfully removed over 20,000 pounds of plastic waste from beaches and parks. Volunteers of all ages have participated in these events, collecting and properly disposing of plastic waste. The initiative has not only cleaned up public spaces but also raised awareness about the importance of reducing plastic use and recycling.',
      'date': '2024-07-05',
    },
    {
      'title': 'Innovative Plastic Waste-to-Energy Technology Introduced',
      'description': 'A new technology that converts plastic waste into clean energy has been introduced in several pilot projects. This technology processes plastic waste through advanced chemical reactions to produce biofuel and electricity. The initiative aims to address the dual challenges of plastic pollution and energy generation, providing a sustainable solution for waste management.',
      'date': '2024-07-07',
    },
    {
      'title': 'Government to Ban Single-Use Plastics by 2025',
      'description': 'The government has announced a comprehensive ban on single-use plastics, including straws, cutlery, and bags, set to take effect by 2025. The ban aims to reduce plastic pollution and encourage the use of eco-friendly alternatives. Businesses will be given time to transition to sustainable products and practices as part of this significant environmental policy.',
      'date': '2024-07-09',
    },
    {
      'title': 'Plastic Pollution Awareness Campaign Gains Momentum',
      'description': 'A new awareness campaign focusing on the dangers of plastic pollution has gained significant traction. The campaign uses social media, educational programs, and public events to highlight the impact of plastic waste on wildlife and ecosystems. It encourages individuals to reduce plastic consumption and participate in local cleanup efforts.',
      'date': '2024-07-11',
    },
    {
      'title': 'Plastic Recycling Rates Reach New Highs',
      'description': 'Recent reports indicate that plastic recycling rates have reached new highs, with over 40% of plastic waste being recycled globally. Advances in recycling technology and increased public awareness have contributed to this improvement. The goal is to further increase recycling rates and reduce the amount of plastic waste that ends up in landfills and oceans.',
      'date': '2024-07-13',
    },
    {
      'title': 'Eco-Friendly Packaging Solutions on the Rise',
      'description': 'Companies are increasingly adopting eco-friendly packaging solutions in response to growing consumer demand for sustainable products. Innovations such as compostable packaging and reusable containers are becoming more common in the market. These changes aim to reduce plastic waste and promote a circular economy.',
      'date': '2024-07-15',
    },
    {
      'title': 'New Plastic Waste Management Policies Announced',
      'description': 'The government has announced a series of new policies aimed at improving plastic waste management. These policies include stricter regulations on plastic production, incentives for recycling programs, and support for research into alternative materials. The goal is to create a more efficient and sustainable system for handling plastic waste.',
      'date': '2024-07-17',
    },
    {
      'title': 'Major Retailers Commit to Reducing Plastic Packaging',
      'description': 'Several major retailers have committed to reducing plastic packaging as part of their sustainability goals. These commitments include using alternative materials, reducing packaging waste, and increasing the use of recyclable materials. The move is expected to have a significant impact on the amount of plastic waste generated by the retail sector.',
      'date': '2024-07-19',
    },
    {
      'title': 'Plastic Pollution Solutions Highlighted at Global Summit',
      'description': 'The recent Global Summit on Plastic Pollution showcased innovative solutions to tackle plastic waste. Experts from around the world presented their research on new technologies, policies, and community initiatives aimed at reducing plastic pollution. The summit emphasized the need for global cooperation and collective action to address this pressing environmental issue.',
      'date': '2024-07-21',
    },
  ];

  // Define a list of pastel colors
  final List<Color> pastelColors = [
    Colors.pink[100]!,
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.yellow[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.teal[100]!,
    Colors.red[100]!,
    Colors.cyan[100]!,
    Colors.lime[100]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.teal[100]! ,
        title: Text('Plastic Eradication News'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final newsItem = newsList[index];
          final color = pastelColors[index % pastelColors.length];
          return _buildNewsCard(newsItem, color);
        },
      ),
    );
  }

  Widget _buildNewsCard(Map<String, String> newsItem, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: color,
      child: ExpansionTile(
        title: Text(
          newsItem['title']!,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(newsItem['date']!),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              newsItem['description']!,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}