import 'package:flutter_application_4/screens/v.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class MyScreen extends StatefulWidget {
  final String stroke;
  final String yes_let;
  final String no_let;

  MyScreen({ required this.stroke, required this.yes_let, required this.no_let}) ;
  
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  late List<double> predictions = [];
  String yes_let = '';
  String no_let = '';
  String stroke = '';
  String biggst = '';
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
    log('data: $_bigVideo');
  }

  Future<void> sendVideoAndGetPrediction(String videoPath) async {
    try {
      final response = await http.put(
        Uri.parse(
          // http://10.0.2.2:5000/upload
          // http://127.0.0.1:5000/upload chrome
            'http://127.0.0.1:5000/upload'), // Replace with your Flask server IP
        body: {'video_path': videoPath},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          predictions = List<double>.from(data['predictions']);
          double maxPrediction = predictions.reduce((curr, next) => curr > next ? curr : next);
          yes_let = predictions[0].toStringAsFixed(1) + '%';
          stroke = predictions[1].toStringAsFixed(1) + '%';
          no_let = predictions[2].toStringAsFixed(1) + '%';
          log('predictions: $predictions');
          log('maxPrediction: $maxPrediction');
          if (maxPrediction == predictions[0]) {
          log('Yes Let: $yes_let');
            biggst='Yes Let';
        } else if (maxPrediction == predictions[1]) {
          log('Stroke: $stroke');
          biggst = 'Stroke';
        } else if (maxPrediction == predictions[2]) {
          log('No Let: $no_let');
        }

        });
      } else {
        setState(() {
          // predictions = 'Failed to get prediction';
        });
      }
    } catch (e) {
      setState(() {
        // predictions = 'Error: $e';
      });
    }
  }

  void _swapVideos(String smallVideo) {
    log('datasmall: $smallVideo');
    setState(() {
      String temp = _bigVideo;
      if (smallVideo == _smallVideo1) {
        _bigVideo = smallVideo;
        _smallVideo1 = temp;
      } else {
        _bigVideo = smallVideo;
        _smallVideo2 = temp;
      }
      // _smallVideo1;
      // _smallVideo2;

      // _bigVideo;
    });
  }
  void checkDecision(String pressedValue) {
  if (pressedValue == biggst) {
    log('Equal');
  } else {
    log('Not Equal');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Recall Screen',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
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
            color: Colors.white,
            height: 3,
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
                // const SizedBox(width: 2),
                GestureDetector(
                  onTap: () => _swapVideos(_smallVideo1),
                  child: VideoPlayerFromAssets(videoPath: _smallVideo1),
                ),
                // const SizedBo
                //
                //x(width: 5),
                GestureDetector(
                  onTap: () => _swapVideos(_smallVideo2),
                  child: VideoPlayerFromAssets(videoPath: _smallVideo2),
                ),
                // const SizedBox(width: 2),
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
                  onPressed: () { //sendVideoAndGetPrediction(
                      //'D:/college/Mobile/flutter_application_4/assets/NoLet(2).mp4');
                      checkDecision('Stroke');
                   }, // Change the video path as needed
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Stroke ${widget.stroke}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: () => checkDecision('No Let'), // Change the video path as needed
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text('No Let ${widget.no_let}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: () => checkDecision('Yes Let'), // Change the video path as needed
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Yes Let ${widget.yes_let}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold)),
                ),
                Text(_bigVideo)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: MyScreen(),
//   ));
// }
