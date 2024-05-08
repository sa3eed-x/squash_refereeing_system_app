import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/v.dart';

class ItemListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Foul List',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome, Ahmed',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: Icon(
                        Icons.video_collection), // Icon before the match name
                    title: Text(
                      matches[index].name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Date: ${matches[index].date}',
                      style: TextStyle(fontSize: 14),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VideoPreviewPage(match: matches[index])),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class ItemListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Match List', style: TextStyle(fontFamily: 'Roboto',color: Colors.white)),
//         backgroundColor: Colors.black,
//       ),
//       body: ListView.builder(
//         itemCount: matches.length,
//         itemBuilder: (context, index) {
//           return Card(
//             elevation: 3,
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: ListTile(
//               contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               title: Text(
//                 matches[index].name,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 'Date: ${matches[index].date}',
//                 style: TextStyle(fontSize: 14),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => VideoPreviewPage(match: matches[index])),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class Match {
  final String name;
  final String date;
  final String videoUrl;

  Match({required this.name, required this.date, required this.videoUrl});
}

final List<Match> matches = [
  Match(name: 'Decision 1', date: '2024-05-01', videoUrl: 'https://example.com/video2.mp4'),
  Match(
      name: 'Decision 2',
      date: '2024-05-02',
      videoUrl: 'https://example.com/video2.mp4'),
  // Add more matches here
];


// ignore: must_be_immutable
class VideoPreviewPage extends StatefulWidget {
  late Match match;
  VideoPreviewPage({required this.match});

  @override
  
  _VideoPreviewPageState createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  late String _bigVideo;
  late String _smallVideo1;
  late String _smallVideo2;

  @override
  void initState() {
    super.initState();
    // _bigVideo = VideoPlayerFromAssets(videoPath: 'NoLet (2).mp4');
    // _smallVideo1 = VideoPlayerFromAssets(
    //     videoPath: 'NoLet (3).mp4'); // Placeholder for the first small video
    // _smallVideo2 = VideoPlayerFromAssets(
    //     videoPath: 'NoLet (4).mp4'); // Placeholder for the second small video
    _bigVideo = "assets/NoLet(2).mp4";
    _smallVideo1 = "assets/NoLet(3).mp4";
    _smallVideo2 = "assets/NoLet(4).mp4";
  }

  void _swapVideos(String smallVideo) {
    setState(() {
      String temp = _bigVideo;
      if (smallVideo == _smallVideo1) {
        _bigVideo = smallVideo;
        _smallVideo1 = temp;
      } else {
        _bigVideo = smallVideo;
        _smallVideo2 = temp;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview: ${widget.match.name} , Date: ${widget.match.date}',style:TextStyle(fontWeight: FontWeight.bold),),
        // backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          // First row with a single smaller video
          Container(
              height: MediaQuery.of(context).size.height * 0.55,
              color: Colors.black,
              child: VideoPlayerFromAssets(videoPath: _bigVideo)),
          const Divider(
            color: Colors.lightBlue,
            height: 4,
          ),
          // Second row with two smaller videos
          Container(
            height: MediaQuery.of(context).size.height * 0.23,
            color: Colors.white70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.black,
                  child: Image.asset(
                    'assets/psaLogo.png',
                    width: 300,
                    height: 250,
                  ),
                ),
                const SizedBox(width: 2),
                GestureDetector(
                  onTap: () => _swapVideos(_smallVideo1),
                  child: VideoPlayerFromAssets(videoPath: _smallVideo1),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () => _swapVideos(_smallVideo2),
                  child: VideoPlayerFromAssets(videoPath: _smallVideo2),
                ),
                const SizedBox(width: 2),
                Container(
                  color: Colors.black,
                  child: Image.asset(
                    'assets/wso.jpg',
                    width: 350,
                    height: 250,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            height: 4,
          ),
          // Third row with three buttons
          Container(
            // color: Colors.lightBlue,
            height: MediaQuery.of(context).size.height * 0.092,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => (), // Change the video path as needed
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Stroke ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: () => (),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text('No Let',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: () => (),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Yes Let',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ItemListPage(),
  ));
}
