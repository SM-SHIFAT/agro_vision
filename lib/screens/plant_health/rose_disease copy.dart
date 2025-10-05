// import 'dart:io';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:glass/glass.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';

// import 'package:permission_handler/permission_handler.dart';
// import 'package:simple_shadow/simple_shadow.dart';
// // import 'package:tflite/tflite.dart';

// import 'constants.dart';
// import 'details_screen.dart';

// class RoseLeafDeseaseDetectionApp extends StatefulWidget {
//   const RoseLeafDeseaseDetectionApp({super.key});

//   @override
//   RoseLeafDeseaseDetectionAppState createState() =>
//       RoseLeafDeseaseDetectionAppState();
// }

// class RoseLeafDeseaseDetectionAppState
//     extends State<RoseLeafDeseaseDetectionApp> {
//   final ImagePicker _picker = ImagePicker();
//   File? _image;

//   bool _disSubmit = false;

//   @override
//   void initState() {
//     super.initState();
//     loadModelData().then((output) {
//       //after loading models, rebuild the UI.
//       setState(() {});
//     });
//   }

//   loadModelData() async {
//     //tensorflow lite plugin loads models and labels.
//     await Tflite.loadModel(
//       model: 'assets/rose_model.tflite',
//       labels: 'assets/leaf_labels.txt',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size _size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color.fromARGB(255, 204, 221, 214),
//         body: Container(
//           height: _size.height,
//           width: _size.width,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment(-0.8, -1),
//               end: Alignment(0.8, 1),
//               colors: [
//                 Color.fromARGB(255, 248, 204, 147),
//                 Color.fromARGB(255, 240, 99, 161),
//               ],
//             ),
//             image: DecorationImage(
//               alignment: Alignment.bottomCenter,
//               image: AssetImage("assets/rose.png"),
//               fit: BoxFit.contain,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // _image != null ? testImage(_size, _image) : titleContent(_size),
//                 titleContent(_size),

//                 const SizedBox(height: 30),
//                 if (_image != null)
//                   Stack(
//                     alignment: AlignmentDirectional.topCenter,
//                     clipBehavior: Clip.none,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         child: Hero(
//                           tag: "hero",
//                           child: Container(
//                             clipBehavior: Clip.hardEdge,
//                             height: _size.width - 40,
//                             width: _size.width - 40,
//                             decoration: BoxDecoration(
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Color.fromARGB(255, 240, 99, 161),
//                                   spreadRadius: 1,
//                                   blurRadius: 4,
//                                   offset: Offset(
//                                     0,
//                                     4,
//                                   ), // changes position of shadow
//                                 ),
//                               ],
//                               image: DecorationImage(
//                                 image: FileImage(_image!),
//                                 fit: BoxFit.cover,
//                               ),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                 color: Color.fromARGB(255, 255, 255, 255),
//                                 width: 4,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: -15,
//                         child: galleryOrCamera(
//                           Icons.arrow_forward,
//                           null,
//                           65,
//                           null,
//                           _disSubmit,
//                           2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 const SizedBox(height: 30),
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                         width: 0,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromARGB(255, 240, 99, 161),
//                           spreadRadius: 1,
//                           blurRadius: 4,
//                           offset: Offset(0, 4), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         galleryOrCamera(
//                           Icons.camera,
//                           ImageSource.camera,
//                           50,
//                           null,
//                           false,
//                           1,
//                         ),
//                         galleryOrCamera(
//                           Icons.photo_album,
//                           ImageSource.gallery,
//                           50,
//                           null,
//                           false,
//                           1,
//                         ),
//                         galleryOrCamera(
//                           Icons.delete,
//                           null,
//                           50,
//                           Colors.amber,
//                           false,
//                           3,
//                         ),
//                       ],
//                     ),
//                   ),
//                   // .asGlass(
//                   //   tintColor: Colors.green,
//                   //   clipBorderRadius: BorderRadius.circular(20),
//                   // ),
//                 ),
//                 const SizedBox(height: 25),

//                 //'It\'s a ${_result![0]['label']}.',
//                 Container(
//                   padding: EdgeInsets.all(12),
//                   margin: EdgeInsets.symmetric(horizontal: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color.fromARGB(255, 240, 99, 161),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: Offset(0, 4), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     '1. Select or Capture the image. \n2. Make sure the diesease area is in center \n    of the iamge.  \n3. Tap the submit button.',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 // .asGlass(
//                 //   tintColor: const Color.fromARGB(255, 204, 221, 214),
//                 //   clipBorderRadius: BorderRadius.circular(20),
//                 // ),
//                 const SizedBox(height: 25),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget titleContent(Size size) {
//     return Stack(
//       children: [
//         SimpleShadow(
//           opacity: 0.3, // Default: 0.5
//           color: Colors.black54, // Default: Black
//           offset: Offset(5, 5), // Default: Offset(2, 2)
//           sigma: 4,
//           child: SvgPicture.asset(
//             'assets/appbar2.svg',
//             alignment: Alignment.topCenter,
//             width: MediaQuery.of(context).size.width,
//           ),
//         ),
//         SimpleShadow(
//           opacity: 0.3, // Default: 0.5
//           color: Colors.black54, // Default: Black
//           offset: Offset(5, 5), // Default: Offset(2, 2)
//           sigma: 4,
//           child: SvgPicture.asset(
//             'assets/appbar1.svg',
//             alignment: Alignment.topCenter,
//             width: MediaQuery.of(context).size.width,
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.only(left: 20, right: 70),
//           //contains 55% of the screen height.
//           //height: size.height * 0.55,
//           width: size.width,

//           //decoration: BoxDecoration(
//           //image: DecorationImage(,
//           //   //color: Colors.white,
//           //   borderRadius: BorderRadius.only(
//           //       bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
//           //   boxShadow: [
//           //     BoxShadow(
//           //       color: Colors.grey.withOpacity(0.5),
//           //       spreadRadius: 5,
//           //       blurRadius: 7,
//           //       offset: Offset(0, 3), // changes position of shadow
//           //     ),
//           //   ],
//           //),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 40),
//                 FittedBox(
//                   child: NeumorphicText(
//                     'RoseVision',
//                     style: NeumorphicStyle(
//                       color: const Color.fromARGB(255, 64, 102, 65),
//                     ),
//                     textStyle: NeumorphicTextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 FittedBox(
//                   child: NeumorphicText(
//                     'Rose leaf disease detection',
//                     style: NeumorphicStyle(
//                       color: const Color.fromARGB(255, 64, 102, 65),
//                     ),
//                     textStyle: NeumorphicTextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   ElevatedButton galleryOrCamera(
//     IconData icon,
//     ImageSource? imageSource,
//     double _bSize,
//     Color? _color,
//     bool dis,
//     int func,
//   ) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
//         elevation: 8,
//         foregroundColor: Colors.white,
//         shape: const CircleBorder(),
//         shadowColor: _color ?? const Color.fromARGB(255, 244, 81, 236),
//       ),
//       //padding: const EdgeInsets.all(6), //14
//       //elevation: 5, //5
//       //  disabledColor: Colors.grey,
//       //  disabledTextColor: Colors.grey,
//       //  disabledElevation: 0,
//       //  color: Colors.white,
//       onPressed: dis
//           ? null
//           : () async {
//               switch (func) {
//                 case 1:
//                   if (await Permission.camera.request().isGranted) {
//                     _getImage(imageSource!);
//                   } else {
//                     Permission.camera.request();
//                   }

//                   break;
//                 case 2:
//                   setState(() {
//                     //make button disabled
//                     _disSubmit = true;
//                   });

//                   List? _result = await detectDisease();
//                   setState(() {
//                     //make button enabled
//                     _disSubmit = false;
//                   });
//                   //navigate to next screen
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           DetailsScreen(result: _result, image: _image),
//                     ),
//                   );
//                   break;
//                 case 3:
//                   _removeImage();
//                   break;
//                 default:
//               }
//             },
//       child: Ink(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: func == 1
//                 ? [
//                     Color.fromARGB(255, 244, 81, 236),
//                     Color.fromARGB(255, 102, 126, 250),
//                   ]
//                 : func == 2
//                 ? [
//                     Color.fromARGB(255, 152, 244, 169),
//                     Color.fromARGB(255, 0, 167, 157),
//                   ]
//                 : [
//                     Color.fromARGB(255, 248, 204, 147),
//                     Color.fromARGB(255, 240, 99, 161),
//                   ],
//           ),
//           shape: BoxShape.circle,
//         ),
//         child: Container(
//           width: _bSize,
//           height: _bSize,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             // color: _color ?? const Color.fromARGB(255, 180, 214, 169),
//           ),
//           child: Icon(icon, size: 20, color: Colors.white),
//         ),
//       ),
//       // Icon(
//       //   icon,
//       //   size: 20,
//       //   color: Colors.grey[800],
//       // ),
//       //  shape: const CircleBorder(),
//     );
//   }

//   void _removeImage() {
//     setState(() {
//       _image = null;
//     });
//   }

//   _getImage(ImageSource imageSource) async {
//     //accessing image from Gallery or Camera.
//     final XFile? _image = await _picker.pickImage(source: imageSource);
//     //image is null, then return
//     if (_image == null) return;
//     setState(() {
//       this._image = File(_image.path);
//     });
//   }

//   Widget testImage(size, image) {
//     return Container(
//       height: size.height * 0.55,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         image: DecorationImage(image: FileImage(image!), fit: BoxFit.cover),
//       ),
//     );
//   }

//   Future<List?> detectDisease() async {
//     List? _res;
//     if (_image != null) {
//       try {
//         _res = await Tflite.runModelOnImage(
//           path: _image!.path,
//           numResults: 1, 
//           threshold: 0.5, 
//           imageMean: 0.0, 
//           imageStd: 255.0, 
//         );
//         return _res;
//       } catch (e) {
//         print(e);
//       }
//       setState(() {});
//     }
//     return _res;
//   }
// }
