import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as image_lib;
import 'package:tflite_flutter/tflite_flutter.dart';

class EmotionDetection {
  EmotionDetection();
  Interpreter? _interpreter;

  /// Labels file loaded as list
  final List<String> _labels = [
    'Angry',
    'Disgusted',
    'Fearful',
    'Happy',
    'Neutral'
  ];

  final String kModelFileName = 'tf/model.tflite';
  final int kImageSize = 48;

  /// Shapes of output tensors
  final List<List<double>> _outputShapes = [
    [0, 1, 2, 3, 4]
  ];

  /// Number of results to show
  final int kNumResults = 5;

  /// convert the gray scalded image to bytes.
  Uint8List _grayscaleToByteListFloat32(image_lib.Image image, int inputSize) {
    final convertedBytes = Float32List(inputSize * inputSize);
    final buffer = Float32List.view(convertedBytes.buffer);
    var pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        final pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = image_lib.getLuminance(pixel) / 255.0;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  /// Runs object detection on the input image
  Future<String> predictFromFile(File image) async {
    _interpreter = await Interpreter.fromAsset(kModelFileName);

    final bytes = image.readAsBytesSync();
    var loadedImage = image_lib.decodeImage(bytes)!;
    loadedImage = image_lib.grayscale(loadedImage);
    loadedImage = image_lib.copyResize(
      loadedImage,
      width: kImageSize,
      height: kImageSize,
    );

    final processedInput = _grayscaleToByteListFloat32(loadedImage, kImageSize);

    // run inference
    _interpreter!.run(processedInput, _outputShapes);

    // Using labelOffset = 1 as ??? at index 0
    final labelOffset = 1;

    for (var i = 0; i < kNumResults; i++) {
      // Label string
      final labelIndex = _outputShapes[0][i] + labelOffset;
      final label = _labels.elementAt(labelIndex.toInt());
      return label;
    }

    return 'Undefined';
  }

  /// Gets the interpreter instance
  Interpreter? get interpreter => _interpreter;

  /// Gets the loaded labels
  List<String>? get labels => _labels;
}