import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as imageLib;
import 'package:musify/API/musify.dart';
import 'homePage.dart';
import 'package:musify/faceRecognition/emotionDetection.dart';

class TakePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emotion Detection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File _image = File('');
  String _selectedEmotion = 'Select Emotion';

  // TODO: Load emotion detection model

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
        // TODO: Pass captured image to the emotion detection model and get the predicted emotion
        emotionDetection test1 = new emotionDetection();
        String result = test1.predict(imageLib.Image.file(_image));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emotion Detection'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.pink,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmotionSelectionScreen()),
                );
              },
              child: Text(
                _selectedEmotion,
                style: TextStyle(fontSize: 20.0),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        tooltip: 'Take Picture',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

class EmotionSelectionScreen extends StatefulWidget {
  @override
  _EmotionSelectionScreenState createState() => _EmotionSelectionScreenState();
}

class _EmotionSelectionScreenState extends State<EmotionSelectionScreen> {
  String _selectedEmotion = '';

  // Define a list of happy playlists or songs
  List<String> happyPlaylists = [
    "Happy Hits",
    "Feelin' Good",
    "Good Vibes",
    "Upbeat",
  ];

  List<String> sadPlaylists = [
    "Heartbreak",
    "Sad Songs",
    "Tearjerkers",
    "Breakup Songs",
  ];

  List<String> angryPlaylists = [
    "Rockin' Rage",
    "Metal Madness",
    "Furious Funk",
    "Punk Power",
  ];

  List<String> surprisedPlaylists = [
    "Mind-Blowing Music",
    "Electrifying Sounds",
    "Unexpected Beats",
    "Offbeat Rhythms",
  ];

  // Use the selected emotion to search for a happy playlist
  void searchPlaylist(String selectedEmotion) {
    if (selectedEmotion == 'Emotion: Happy') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Suggested Playlist'),
            content: Text('Here\'s a happy playlist: ${happyPlaylists[0]}'),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (selectedEmotion == 'Emotion: Sad') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Suggested Playlist'),
              content: Text('Here\'s a sad playlist: ${sadPlaylists[0]}'),
              actions: [
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      // Display a sad playlist
    } else if (selectedEmotion == 'Emotion: Angry') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Suggested Playlist'),
            content: Text('Here\'s an angry playlist: ${angryPlaylists[0]}'),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // Display an angry playlist
    } else if (selectedEmotion == 'Emotion: Surprised') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Suggested Playlist'),
            content: Text('Here\'s a surprised playlist: ${surprisedPlaylists[0]}'),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // Display a surprised playlist
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Emotion'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedEmotion = 'Emotion: Happy';
                });
                searchPlaylist(_selectedEmotion);
              },
              child: Text('Happy'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedEmotion = 'Emotion: Sad';
                });
                searchPlaylist(_selectedEmotion);
              },
              child: Text('Sad'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedEmotion = 'Emotion: Angry';
                });
                searchPlaylist(_selectedEmotion);
              },
              child: Text('Angry'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedEmotion = 'Emotion: Surprised';
                });
                searchPlaylist(_selectedEmotion);
              },
              child: Text('Surprised'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedEmotion);
              },
              child: Text('Return'),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

