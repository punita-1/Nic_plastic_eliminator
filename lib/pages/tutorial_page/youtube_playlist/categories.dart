import 'package:flutter/material.dart';
import 'video_list.dart';

class Categories extends StatelessWidget {
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
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  categories[index],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => VideoList(
                        category: categories[index],
                        playlistId: categoryPlaylists[categories[index]]!,
                      ),
                    ),
                  );
                },
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}
