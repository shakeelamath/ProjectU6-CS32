import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as imageLib;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class emotionDetection {
  Interpreter? _interpreter;

  /// Labels file loaded as list
  List<String> _labels= ["Angry", "Disgusted", "Fearful", "Happy", "Neutral"];

  static const String MODEL_FILE_NAME = "model.tflite";

  /// Input size of image (height = width = 300)
  static const int INPUT_SIZE = 300;

  /// Result score threshold
  static const double THRESHOLD = 0.5;

  /// [ImageProcessor] used to pre-process the image
  ImageProcessor? imageProcessor;


  /// Padding the image to transform into square
  int? padSize;

  /// Shapes of output tensors
  List<List<int>>? _outputShapes;

  /// Types of output tensors
  List<TfLiteType>? _outputTypes;

  /// Number of results to show
  static const int NUM_RESULTS = 10;

  emotionDetection() {
    loadModel();
  }

  /// Loads interpreter from asset
  void loadModel({Interpreter? interpreter}) async {
    try {
      _interpreter = interpreter ??
          await Interpreter.fromAsset(
            MODEL_FILE_NAME,
            options: InterpreterOptions()..threads = 4,
          );

      var outputTensors = _interpreter!.getOutputTensors();
      _outputShapes = [];
      _outputTypes = [];
      outputTensors.forEach((tensor) {
        _outputShapes!.add(tensor.shape);
        _outputTypes!.add(tensor.type);
      });
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }

  /// Loads labels from assets
  void loadLabels({required List<String> labels}) async {
    try {
      _labels =
          ["Angry", "Disgusted", "Fearful", "Happy", "Neutral"];
    } catch (e) {
      print("Error while loading labels: $e");
    }
  }

  /// Pre-process the image
  TensorImage getProcessedImage(TensorImage inputImage) {
    padSize = max(inputImage.height, inputImage.width);
    imageProcessor ??= ImageProcessorBuilder()
          .add(ResizeWithCropOrPadOp(padSize!, padSize!))
          .add(ResizeOp(INPUT_SIZE, INPUT_SIZE, ResizeMethod.BILINEAR))
          .build();
    inputImage = imageProcessor!.process(inputImage);
    return inputImage;
  }

  /// Runs object detection on the input image
 String predict(imageLib.Image image) {

    if (_interpreter == null) {
      print("Interpreter not initialized");
      return "undefined";
    }
    // Create TensorImage from image
    TensorImage inputImage = TensorImage.fromImage(image);

    // Pre-process TensorImage
    inputImage = getProcessedImage(inputImage);

    // TensorBuffers for output tensors
    TensorBuffer outputLocations = TensorBufferFloat(_outputShapes![0]);
    TensorBuffer outputClasses = TensorBufferFloat(_outputShapes![1]);
    TensorBuffer outputScores = TensorBufferFloat(_outputShapes![2]);
    TensorBuffer numLocations = TensorBufferFloat(_outputShapes![3]);

    // Inputs object for runForMultipleInputs
    // Use [TensorImage.buffer] or [TensorBuffer.buffer] to pass by reference
    List<Object> inputs = [inputImage.buffer];

    // Outputs map
    Map<int, Object> outputs = {
      0: outputLocations.buffer,
      1: outputClasses.buffer,
      2: outputScores.buffer,
      3: numLocations.buffer,
    };

    // run inference
    _interpreter!.runForMultipleInputs(inputs, outputs);

    // Maximum number of results to show
    int resultsCount = min(NUM_RESULTS, numLocations.getIntValue(0));

    // Using labelOffset = 1 as ??? at index 0
    int labelOffset = 1;

    for (int i = 0; i < resultsCount; i++) {
      // Label string
      var labelIndex = outputClasses.getIntValue(i) + labelOffset;
      var label = _labels!.elementAt(labelIndex);
      return label;

    }

    return "undefined";
  }

  /// Gets the interpreter instance
  Interpreter? get interpreter => _interpreter;

  /// Gets the loaded labels
  List<String>? get labels => _labels;
}



