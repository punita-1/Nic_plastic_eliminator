// // ignore_for_file: use_key_in_widget_constructors, depend_on_referenced_packages

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:plastic_eliminator/core/constants.dart';
// import 'package:plastic_eliminator/features/tutorials/player.dart'; // Import the Config class

// /// A stateful widget that displays a list of videos from a YouTube playlist.
// class VideoList extends StatefulWidget {
//   /// The category name to be displayed in the AppBar.
//   final String category;

//   /// The ID of the YouTube playlist to fetch videos from.
//   final String playlistId;

//   /// Creates a [VideoList] widget with the given [category] and [playlistId].
//   const VideoList({required this.category, required this.playlistId});

//   @override
//   _VideoListState createState() => _VideoListState();
// }

// class _VideoListState extends State<VideoList> {
//   /// A future that holds the list of videos fetched from the playlist.
//   late Future<List<Map<String, dynamic>>> _videos;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the videos from the playlist when the widget is initialized.
//     _videos = fetchPlaylistVideos(widget.playlistId);
//   }

//   /// Fetches videos from a given YouTube playlist using the YouTube API.
//   Future<List<Map<String, dynamic>>> fetchPlaylistVideos(
//       String playlistId) async {
//     const apiKey = Config.youtubeApiKey; // Use API key from Config
//     final url =
//         'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=$playlistId&key=$apiKey';

//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final List items = data['items'];
//         return items.map((item) {
//           return {
//             'title': item['snippet']['title'],
//             'description': item['snippet']['description'],
//             'url': item['snippet']['resourceId']['videoId'],
//           };
//         }).toList();
//       } else {
//         throw Exception('Failed to load playlist: ${response.statusCode}');
//       }
//     } catch (e) {
//       // print('Error fetching playlist videos: $e');
//       return [];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           widget.category,
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _videos,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Show a loading indicator while waiting for data.
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             // Show an error message if the data fetch fails.
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             // Show a message if no videos are available.
//             return Center(child: Text('No videos available'));
//           }

//           final videos = snapshot.data!;

//           // Display the list of videos in a ListView.
//           return ListView.builder(
//             padding: EdgeInsets.all(8),
//             itemCount: videos.length,
//             itemBuilder: (context, index) {
//               final video = videos[index];
//               final videoID = video['url'] as String;

//               return Card(
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: InkWell(
//                   onTap: () {
//                     // Navigate to the video player screen when a video is tapped.
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => PlayerScreen(videoId: videoID),
//                     ));
//                   },
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Display the video thumbnail.
//                       ClipRRect(
//                         borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(10)),
//                         child: Image.network(
//                           'https://img.youtube.com/vi/$videoID/0.jpg',
//                           fit: BoxFit.cover,
//                           height: 200,
//                           width: double.infinity,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           video['title'] as String,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                           video['description'] as String,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
// ignore_for_file: use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:plastic_eliminator/core/constants.dart';
import 'package:plastic_eliminator/features/tutorials/player.dart'; // Import the Config class

/// A stateful widget that displays a list of videos from a YouTube playlist.
class VideoList extends StatefulWidget {
  /// The category name to be displayed in the AppBar.
  final String category;

  /// The ID of the YouTube playlist to fetch videos from.
  final String playlistId;

  /// Creates a [VideoList] widget with the given [category] and [playlistId].
  const VideoList({required this.category, required this.playlistId});

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  /// A future that holds the list of videos fetched from the playlist.
  late Future<List<Map<String, dynamic>>> _videos;

  @override
  void initState() {
    super.initState();
    // Fetch the videos from the playlist when the widget is initialized.
    _videos = fetchPlaylistVideos(widget.playlistId);
  }

  /// Fetches videos from a given YouTube playlist using the YouTube API.
  Future<List<Map<String, dynamic>>> fetchPlaylistVideos(
      String playlistId) async {
    const apiKey = Config.youtubeApiKey; // Use API key from Config
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
            'videoId': item['snippet']['resourceId']['videoId'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load playlist: ${response.statusCode}');
      }
    } catch (e) {
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
            // Show a loading indicator while waiting for data.
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show an error message if the data fetch fails.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Show a message if no videos are available.
            return Center(child: Text('No videos available'));
          }

          final videos = snapshot.data!;

          // Display the list of videos in a ListView.
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              final videoID = video['videoId'] as String;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    // Navigate to the video player screen when a video is tapped.
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlayerScreen(videoId: videoID),
                    ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the video thumbnail.
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
