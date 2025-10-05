import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkScreen extends StatelessWidget {
  LinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "Information Source",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: Container(
          height: _size.height,
          width: _size.width,
          color: Colors.white,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Disease & control related information Source:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                softWrap: true,
              ),
              Divider(),
              TextButton(
                onPressed: () async {
                  await _launchUrl(
                      "https://www.rhs.org.uk/disease/rose-black-spot");
                },
                child: Text("1. rhs.org.uk"),
              ),
              TextButton(
                onPressed: () async {
                  await _launchUrl(
                      "https://gardenerspath.com/plants/flowers/downy-mildew-roses/");
                },
                child: Text("2. gardenerspath.com"),
              ),
              TextButton(
                onPressed: () async {
                  await _launchUrl(
                      "https://www.greenhousemag.com/news/research-advances-for-downy-mildew-control-on-rose/");
                },
                child: Text("3. greenhousemag.com"),
              ),
              TextButton(
                onPressed: () async {
                  await _launchUrl(
                      "https://www.gardentech.com/blog/garden-and-lawn-protection/fighting-black-spot-on-roses");
                },
                child: Text("4. gardentech.com"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(URL) async {
    final Uri url = Uri.parse(URL);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: WebViewConfiguration(enableJavaScript: true),
      );
    } else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }
}
