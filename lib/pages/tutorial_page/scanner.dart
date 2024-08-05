import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/tutorial_page/player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final Map<String, List<Map<String, String>>> categoryVideos = {
  'Home Recycling': [
    {
      'url': 'https://www.youtube.com/watch?v=-EEMit5sr5s',
      'title': 'How to Recycle Plastic at Home',
      'description': 'Learn simple ways to recycle plastic waste at home.'
    },
    // Add more videos
  ],
  'Plastic Management': [
    {
      'url': 'https://www.youtube.com/watch?v=-EEMit5sr5s',
      'title': 'Plastic Waste Management',
      'description': 'Effective methods for managing plastic waste.'
    },
    // Add more videos
  ],
  'Creative Reuse': [
    {
      'url': 'https://www.youtube.com/watch?v=-EEMit5sr5s',
      'title': 'How to Recycle Plastic at Home',
      'description': 'Learn simple ways to recycle plastic waste at home.'
    },
    // Add more videos
  ],
  'DIY Projects': [
    {
      'url': 'https://www.youtube.com/watch?v=-EEMit5sr5s',
      'title': 'How to Recycle Plastic at Home',
      'description': 'Learn simple ways to recycle plastic waste at home.'
    },
    // Add more videos
  ],
  'Sustainable Living': [
    {
      'url': 'https://www.youtube.com/watch?v=-EEMit5sr5s',
      'title': 'How to Recycle Plastic at Home',
      'description': 'Learn simple ways to recycle plastic waste at home.'
    },
    // Add more videos
  ],
  'Community Efforts': [
    {
      'url': 'https://www.youtube.com/watch?v=-EEMit5sr5s',
      'title': 'How to Recycle Plastic at Home',
      'description': 'Learn simple ways to recycle plastic waste at home.'
    },
    // Add more videos
  ],
  'Educational Resources': [
    {
      'url': 'https://www.youtube.com/watch?v=-EEMit5sr5s',
      'title': 'How to Recycle Plastic at Home',
      'description': 'Learn simple ways to recycle plastic waste at home.'
    },
    // Add more videos
  ],
  'Environmental Impact': [
    {
      'url': 'https://www.youtube.com/watch?v=-EEMit5sr5s',
      'title': 'How to Recycle Plastic at Home',
      'description': 'Learn simple ways to recycle plastic waste at home.'
    },
    {
      'url': 'https://www.youtube.com/watch?v=-EEMit5sr5s',
      'title': 'How to Recycle Plastic at Home',
      'description': 'Learn simple ways to recycle plastic waste at home.'
    },
    // Add more videos
  ],
  // Add more categories and videos
};

class VideoList extends StatelessWidget {
  final String category;

  VideoList({required this.category});

  @override
  Widget build(BuildContext context) {
    final videos = categoryVideos[category]!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tutorials',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          final videoID = YoutubePlayer.convertUrlToId(video['url']!);
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlayerScreen(videoId: videoID),
                ));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      YoutubePlayer.getThumbnail(videoId: videoID!),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      video['title']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      video['description']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
