import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../API/musify.dart';
import 'homePage.dart';


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
        // You can update the UI here based on the predicted emotion
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
              child: Text('Select'),
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


class EmotionSelectionScreen2 extends StatefulWidget {
  @override
  _EmotionSelectionScreenState createState() => _EmotionSelectionScreenState();
}

class _EmotionSelectionScreenState2 extends State<EmotionSelectionScreen> {
  String _selectedEmotion = '';

  void _playSong(String emotion) {
    switch (emotion) {
      case 'Happy':
      // code to play happy song
        print('Playing happy song!');
        break;
      case 'Sad':
      // code to play sad song
        print('Playing sad song!');
        break;
      case 'Angry':
      // code to play angry song
        print('Playing angry song!');
        break;
      case 'Surprised':
      // code to play surprised song
        print('Playing surprised song!');
        break;
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
                  _selectedEmotion = 'Happy';
                });
                _playSong('Happy');
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
                  _selectedEmotion = 'Sad';
                });
                _playSong('Sad');
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
                  _selectedEmotion = 'Angry';
                });
                _playSong('Angry');
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
                  _selectedEmotion = 'Surprised';
                });
                _playSong('Surprised');
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
              child: Text('Select'),
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


