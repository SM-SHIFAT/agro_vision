import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'link_screen.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key, required this.result, this.image}) : super(key: key);

  final List? result;
  final File? image;
  List<String>? details;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    details();
    super.initState();
  }

  void details() async {
    var myData = json.decode(await getJson());
    widget.details = await myData[widget.result![0]['label']].cast<String>();
    print(widget.details);
    setState(() {});
  }

  final _headerStyle = const TextStyle(
    color: Color(0xffffffff),
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  final _contentStyle = const TextStyle(
    color: Color.fromARGB(255, 59, 59, 59),
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: _size.height,
          width: _size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.8, -1),
              end: Alignment(0.8, 1),
              colors: [
                Color.fromARGB(255, 150, 240, 165),
                Color.fromARGB(255, 0, 167, 157),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Lottie.asset(
                    "assets/waving_leaf.json",
                    width: _size.width / 2,
                  ),
                ),
              ),
              Container(
                height: _size.height,
                width: _size.width,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                            padding: const EdgeInsets.all(15),
                          ),
                          const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: _size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: 5,
                                right: 5,
                                bottom: 5,
                                left: 5,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    "${widget.result![0]['label']}" ==
                                        "Fresh Leaf"
                                    ? Color.fromARGB(255, 53, 255, 60)
                                    : Color.fromARGB(255, 236, 92, 82),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(19),
                                  bottomRight: Radius.circular(19),
                                  topLeft: Radius.circular(19),
                                  bottomLeft: Radius.circular(19),
                                ),
                              ),
                              child: Hero(
                                tag: "hero",
                                child: Container(
                                  width: (_size.width / 2) - 20,
                                  height: (_size.width / 2) - 20,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(widget.image!),
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.yellow,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: (_size.width / 2) - 40,
                              height: (_size.width / 2),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Status"),
                                  "${widget.result![0]['label']}" ==
                                          "Fresh Leaf"
                                      ? const Icon(
                                          Icons.check_circle,
                                          size: 30,
                                          color: Color.fromARGB(
                                            255,
                                            122,
                                            255,
                                            46,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.cancel_rounded,
                                          size: 25,
                                          color: Colors.red,
                                        ),
                                  const SizedBox(height: 10),
                                  "${widget.result![0]['label']}" ==
                                          "Fresh Leaf"
                                      ? Text("Condition")
                                      : Text("Disease"),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${widget.result![0]['label']}",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: PhysicalModel(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: const Color.fromARGB(111, 255, 255, 255),
                          elevation: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "${widget.result![0]['label']}" !=
                                            "Fresh Leaf"
                                        ? "What is ${widget.result![0]['label']}?"
                                        : "Tips for Growing Healthy Roses",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(),
                              Container(
                                padding: EdgeInsets.all(12),
                                width: _size.width,
                                child: Text(
                                  widget.details != null
                                      ? widget.details![0]
                                      : "",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      if ("${widget.result![0]['label']}" != "Fresh Leaf")
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: PhysicalModel(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: const Color.fromARGB(111, 255, 255, 255),
                            elevation: 10,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: _size.width,
                              child: Accordion(
                                disableScrolling: true,
                                maxOpenSections: 5,
                                headerBackgroundColorOpened: Colors.black54,
                                openAndCloseAnimation: false,
                                headerPadding: const EdgeInsets.symmetric(
                                  vertical: 7,
                                  horizontal: 15,
                                ),
                                sectionOpeningHapticFeedback:
                                    SectionHapticFeedback.heavy,
                                sectionClosingHapticFeedback:
                                    SectionHapticFeedback.light,
                                paddingListBottom: 10,
                                children: [
                                  AccordionSection(
                                    isOpen: false,
                                    leftIcon: const Icon(
                                      Icons.insights_rounded,
                                      color: Colors.white,
                                    ),
                                    headerBackgroundColor: Color.fromARGB(
                                      255,
                                      23,
                                      118,
                                      196,
                                    ),
                                    headerBackgroundColorOpened: Colors.red,
                                    header: Text(
                                      'Symptoms',
                                      style: _headerStyle,
                                    ),
                                    content: Text(
                                      widget.details != null
                                          ? widget.details![1]
                                          : "",
                                      style: _contentStyle,
                                    ),
                                    contentHorizontalPadding: 10,
                                    contentBorderWidth: 2,
                                  ),
                                  AccordionSection(
                                    isOpen: false,
                                    leftIcon: const Icon(
                                      Icons.insights_rounded,
                                      color: Colors.white,
                                    ),
                                    headerBackgroundColor: Color.fromARGB(
                                      255,
                                      23,
                                      118,
                                      196,
                                    ),
                                    headerBackgroundColorOpened: Colors.red,
                                    header: Text(
                                      'Spread and survival',
                                      style: _headerStyle,
                                    ),
                                    content: Text(
                                      widget.details != null
                                          ? widget.details![2]
                                          : "",
                                      style: _contentStyle,
                                    ),
                                    contentHorizontalPadding: 10,
                                    contentBorderWidth: 2,
                                  ),
                                  AccordionSection(
                                    isOpen: false,
                                    leftIcon: const Icon(
                                      Icons.insights_rounded,
                                      color: Colors.white,
                                    ),
                                    headerBackgroundColor: Color.fromARGB(
                                      255,
                                      23,
                                      118,
                                      196,
                                    ),
                                    headerBackgroundColorOpened: Colors.red,
                                    header: Text(
                                      'Control',
                                      style: _headerStyle,
                                    ),
                                    content: Text(
                                      widget.details != null
                                          ? widget.details![3]
                                          : "",
                                      style: _contentStyle,
                                    ),
                                    contentHorizontalPadding: 10,
                                    contentBorderWidth: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 60),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        icon: Icon(Icons.info_outline_rounded),
                        label: Text("Information Source"),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LinkScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getJson() {
    return rootBundle.loadString('assets/details.json');
  }
}
