import 'dart:io';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glass/glass.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'package:permission_handler/permission_handler.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

// import 'package:tflite/tflite.dart';

import 'constants.dart';
import 'details_screen.dart';

class RoseLeafDeseaseDetectionApp extends StatefulWidget {
  const RoseLeafDeseaseDetectionApp({super.key});

  @override
  RoseLeafDeseaseDetectionAppState createState() =>
      RoseLeafDeseaseDetectionAppState();
}

class RoseLeafDeseaseDetectionAppState
    extends State<RoseLeafDeseaseDetectionApp> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  bool _disSubmit = false;

  Interpreter? _interpreter;
  List<String>? _labels;

  @override
  void initState() {
    super.initState();
    loadModelData().then((output) {
      //after loading models, rebuild the UI.
      setState(() {});
    });
  }

  Future<void> loadModelData() async {
    try {
      // Load TFLite model
      InterpreterOptions options = InterpreterOptions();
      _interpreter = await Interpreter.fromAsset(
        'assets/rose_model.tflite',
        options: options,
      );

      // Load label file
      final labelsData = await rootBundle.loadString('assets/leaf_labels.txt');
      _labels = labelsData
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      print('✅ Model and labels loaded successfully.');
    } catch (e) {
      print('❌ Error loading model: $e');
    }
  }

  @override
  void dispose() {
    _interpreter?.close();
    _interpreter = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 221, 214),
      appBar: AppBar(
        title: const Text('Rose Leaf Disease Detection'),
        backgroundColor: const Color.fromARGB(255, 132, 191, 135),
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.8, -1),
            end: Alignment(0.8, 1),
            colors: [
              Color.fromARGB(255, 248, 204, 147),
              Color.fromARGB(255, 240, 99, 161),
            ],
          ),
          image: DecorationImage(
            alignment: Alignment.bottomCenter,
            image: AssetImage("assets/rose.png"),
            fit: BoxFit.contain,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // _image != null ? testImage(_size, _image) : titleContent(_size),
              // titleContent(_size),
              const SizedBox(height: 30),
              if (_image != null)
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Hero(
                        tag: "hero",
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: _size.width - 40,
                          width: _size.width - 40,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 240, 99, 161),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(
                                  0,
                                  4,
                                ), // changes position of shadow
                              ),
                            ],
                            image: DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      child: galleryOrCamera(
                        Icons.arrow_forward,
                        null,
                        65,
                        null,
                        _disSubmit,
                        2,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color.fromARGB(255, 255, 255, 255),
                      width: 0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 240, 99, 161),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      galleryOrCamera(
                        Icons.camera,
                        ImageSource.camera,
                        50,
                        null,
                        false,
                        1,
                      ),
                      galleryOrCamera(
                        Icons.photo_album,
                        ImageSource.gallery,
                        50,
                        null,
                        false,
                        1,
                      ),
                      galleryOrCamera(
                        Icons.delete,
                        null,
                        50,
                        Colors.amber,
                        false,
                        3,
                      ),
                    ],
                  ),
                ),
                // .asGlass(
                //   tintColor: Colors.green,
                //   clipBorderRadius: BorderRadius.circular(20),
                // ),
              ),
              const SizedBox(height: 25),

              //'It\'s a ${_result![0]['label']}.',
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 240, 99, 161),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Text(
                  '1. Select or Capture the image. \n2. Make sure the diesease area is in center \n    of the iamge.  \n3. Tap the submit button.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // .asGlass(
              //   tintColor: const Color.fromARGB(255, 204, 221, 214),
              //   clipBorderRadius: BorderRadius.circular(20),
              // ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleContent(Size size) {
    return Stack(
      children: [
        SimpleShadow(
          opacity: 0.3, // Default: 0.5
          color: Colors.black54, // Default: Black
          offset: Offset(5, 5), // Default: Offset(2, 2)
          sigma: 4,
          child: SvgPicture.asset(
            'assets/appbar2.svg',
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        SimpleShadow(
          opacity: 0.3, // Default: 0.5
          color: Colors.black54, // Default: Black
          offset: Offset(5, 5), // Default: Offset(2, 2)
          sigma: 4,
          child: SvgPicture.asset(
            'assets/appbar1.svg',
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 70),
          //contains 55% of the screen height.
          //height: size.height * 0.55,
          width: size.width,

          //decoration: BoxDecoration(
          //image: DecorationImage(,
          //   //color: Colors.white,
          //   borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey.withOpacity(0.5),
          //       spreadRadius: 5,
          //       blurRadius: 7,
          //       offset: Offset(0, 3), // changes position of shadow
          //     ),
          //   ],
          //),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                FittedBox(
                  child: NeumorphicText(
                    'RoseVision',
                    style: NeumorphicStyle(
                      color: const Color.fromARGB(255, 64, 102, 65),
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FittedBox(
                  child: NeumorphicText(
                    'Rose leaf disease detection',
                    style: NeumorphicStyle(
                      color: const Color.fromARGB(255, 64, 102, 65),
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ElevatedButton galleryOrCamera(
    IconData icon,
    ImageSource? imageSource,
    double _bSize,
    Color? _color,
    bool dis,
    int func,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
        elevation: 8,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        shadowColor: _color ?? const Color.fromARGB(255, 244, 81, 236),
      ),
      //padding: const EdgeInsets.all(6), //14
      //elevation: 5, //5
      //  disabledColor: Colors.grey,
      //  disabledTextColor: Colors.grey,
      //  disabledElevation: 0,
      //  color: Colors.white,
      onPressed: dis
          ? null
          : () async {
              switch (func) {
                case 1:
                  if (await Permission.camera.request().isGranted) {
                    _getImage(imageSource!);
                  } else {
                    Permission.camera.request();
                  }

                  break;
                case 2:
                  setState(() {
                    //make button disabled
                    _disSubmit = true;
                  });

                  List? _result = await detectDisease();
                  setState(() {
                    //make button enabled
                    _disSubmit = false;
                  });
                  //navigate to next screen
                  print(_result);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(result: _result, image: _image),
                    ),
                  );
                  break;
                case 3:
                  _removeImage();
                  break;
                default:
              }
            },
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: func == 1
                ? [
                    Color.fromARGB(255, 244, 81, 236),
                    Color.fromARGB(255, 102, 126, 250),
                  ]
                : func == 2
                ? [
                    Color.fromARGB(255, 152, 244, 169),
                    Color.fromARGB(255, 0, 167, 157),
                  ]
                : [
                    Color.fromARGB(255, 248, 204, 147),
                    Color.fromARGB(255, 240, 99, 161),
                  ],
          ),
          shape: BoxShape.circle,
        ),
        child: Container(
          width: _bSize,
          height: _bSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: _color ?? const Color.fromARGB(255, 180, 214, 169),
          ),
          child: Icon(icon, size: 20, color: Colors.white),
        ),
      ),
      // Icon(
      //   icon,
      //   size: 20,
      //   color: Colors.grey[800],
      // ),
      //  shape: const CircleBorder(),
    );
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  _getImage(ImageSource imageSource) async {
    //accessing image from Gallery or Camera.
    final XFile? _image = await _picker.pickImage(source: imageSource);
    //image is null, then return
    if (_image == null) return;
    setState(() {
      this._image = File(_image.path);
    });
  }

  Widget testImage(size, image) {
    return Container(
      height: size.height * 0.55,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: FileImage(image!), fit: BoxFit.cover),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> detectDisease() async {
    if (_interpreter == null || _labels == null) {
      print('⚠️ Model not loaded yet. Call loadModelData() first.');
      return [];
    }
    if (_image == null) {
      print('⚠️ No image selected. Call setImage(File image) first.');
      return [];
    }

    _interpreter!.allocateTensors();
    final inputTensor = _interpreter!.getInputTensor(0);
    print('Shape: ${inputTensor.shape}');
    print('Type: ${inputTensor.type}');
    print('Name: ${inputTensor.name}');

    try {
      final imageBytes = await _image!.readAsBytes();
      img.Image? oriImage = img.decodeImage(imageBytes);
      if (oriImage == null) return [];

      // adjust inputSize to your model if it's not 224
      const int inputSize = 224;
      // img.Image resizedImage = img.copyResize(
      //   oriImage,
      //   width: inputSize,
      //   height: inputSize,
      // );

      var resizedImage = img.copyResize(oriImage, width: 224, height: 224);

      // get Float32List input
      // final input = _imageToByteListFloat32(resizedImage, inputSize, 0, 255);

      var input = imageTo4D(resizedImage);
      var output = List.filled(
        _labels!.length,
        0.0,
      ).reshape([1, _labels!.length]);

      // prepare output buffer
      // var output = List.filled(
      //   _labels!.length,
      //   0.0,
      // ).reshape([1, _labels!.length]);

      // run inference
      _interpreter!.run(input, output);

      // postprocess
      final results = _getTopResults(
        output[0],
        _labels!,
        threshold: 0.5,
        topK: 1,
      );
      return results;
    } catch (e) {
      print('❌ Error during detection: $e');
      return [];
    }
  }

  /// Convert image to Float32List in NHWC order: [1, inputSize, inputSize, 3]
  Float32List _imageToByteListFloat32(
    img.Image image,
    int inputSize,
    double mean,
    double std,
  ) {
    final Float32List converted = Float32List(
      inputSize * inputSize * 3,
    ); // 1D vector
    int idx = 0;

    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final pixel = image.getPixel(x, y);
        final r = pixel.r.toDouble();
        final g = pixel.g.toDouble();
        final b = pixel.b.toDouble();

        converted[idx++] = (r - mean) / std;
        converted[idx++] = (g - mean) / std;
        converted[idx++] = (b - mean) / std;
      }
    }

    return converted; // still 1D, matches model shape [150528]
  }

  List<Map<String, dynamic>> _getTopResults(
    List output,
    List<String> labels, {
    double threshold = 0.5,
    int topK = 1,
  }) {
    final List<Map<String, dynamic>> results = [];
    for (int i = 0; i < output.length; i++) {
      final double confidence = output[i] is double
          ? output[i]
          : (output[i] as num).toDouble();
      if (confidence >= threshold) {
        results.add({'label': labels[i], 'confidence': confidence});
      }
    }
    results.sort((a, b) => (b['confidence']).compareTo(a['confidence']));
    return results.length > topK ? results.sublist(0, topK) : results;
  }

  List<List<List<List<double>>>> imageTo4D(img.Image image) {
    final int height = image.height;
    final int width = image.width;

    return [
      List.generate(
        height,
        (y) => List.generate(width, (x) {
          final pixel = image.getPixel(x, y);
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        }),
      ),
    ]; // shape [1,H,W,3]
  }
}
