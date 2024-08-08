import 'dart:convert';
import 'package:http/http.dart' as http;

class YouTubeService {
  final String apiKey;

  YouTubeService(this.apiKey);

  Future<List<Map<String, dynamic>>> fetchPlaylistVideos(
      String playlistId) async {
    final url =
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=$playlistId&key=$apiKey';

    print('Request URL: $url'); // Log the request URL

    try {
      final response = await http.get(Uri.parse(url));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'] as List;
        return items.map((item) {
          return {
            'title': item['snippet']['title'],
            'description': item['snippet']['description'],
            'url':
                'https://www.youtube.com/watch?v=${item['snippet']['resourceId']['videoId']}',
          };
        }).toList();
      } else {
        throw Exception('Failed to load playlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching playlist videos: $e');
      throw Exception('Error fetching playlist videos');
    }
  }
}
