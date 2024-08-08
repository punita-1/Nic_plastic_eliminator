import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plastic_eliminator/pages/tutorial_page/player.dart';
import 'dart:convert';
// import 'player.dart'; // Assuming you have a PlayerScreen for video playback

class VideoList extends StatefulWidget {
  final String category;
  final String playlistId;

  VideoList({required this.category, required this.playlistId});

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late Future<List<Map<String, dynamic>>> _videos;

  @override
  void initState() {
    super.initState();
    _videos = fetchPlaylistVideos(widget.playlistId);
  }

  Future<List<Map<String, dynamic>>> fetchPlaylistVideos(
      String playlistId) async {
    final apiKey = 'AIzaSyAELF0M1eG8d43zIN3UOLuG_ji7o1DXEa4';
    final url =
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=$playlistId&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List items = data['items'];
        return items.map((item) {
          return {
            'title': item['snippet']['title'],
            'description': item['snippet']['description'],
            'url': item['snippet']['resourceId']['videoId'],
          };
        }).toList();
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load playlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching playlist videos: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.category,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _videos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No videos available'));
          }

          final videos = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              final videoID = video['url'] as String;

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
                          'https://img.youtube.com/vi/$videoID/0.jpg',
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          video['title'] as String,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          video['description'] as String,
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
          );
        },
      ),
    );
  }
}
