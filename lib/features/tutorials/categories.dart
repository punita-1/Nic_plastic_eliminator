// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'video_list.dart';

/// A screen that displays a list of video categories.
/// Tapping on a category navigates to the [VideoList] screen, displaying
/// videos from the selected YouTube playlist.
class Categories extends StatelessWidget {
  // A map of category names to their respective YouTube playlist IDs
  final Map<String, String> categoryPlaylists = {
    'Home Recycling': 'PLxHWbyWxvx_ISvUfn0ND5aUPAUOID7Man',
    'Plastic Management': 'PLxHWbyWxvx_LbWPZXzNOSwpwiBwuddx6l',
    'Creative Reuse': 'PLxHWbyWxvx_L1ndic4tT5OyspFFLr2TRo',
    'Environmental Impact': 'PLxHWbyWxvx_I0YLRzRHzlZe1kcOwbY3aH',
    'DIY Projects': 'PLxHWbyWxvx_IQ24vFT8ZtpY7I2X3hJaju',
    'Sustainable Living': 'PLxHWbyWxvx_KbyA2W8TTzCZV5inlfkdck',
    'Community Efforts': 'PLxHWbyWxvx_LASeECJJI26KrUOuHA7bbY',
    'Educational Resources': 'PLxHWbyWxvx_I4WLAdP4z9-WhVIe87QyAQ',
  };

  @override
  Widget build(BuildContext context) {
    // Convert the map keys to a list for display
    final categories = categoryPlaylists.keys.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Let's Learn",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        // ListView.separated is used for creating a list with separators
        itemCount: categories.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(
              category,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to the VideoList screen with the selected category and playlist ID
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VideoList(
                    category: category,
                    playlistId: categoryPlaylists[category]!,
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
