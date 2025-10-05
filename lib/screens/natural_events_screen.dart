import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url =
      "https://worldview.earthdata.nasa.gov/?v=71.26864685256413,13.487571923558246,108.79794109005164,30.438944210915334&z=4&ics=true&ici=5&icd=30&e=EONET_15683,2025-10-03&efs=true&efa=false&efd=2025-06-06,2025-10-04&efc=dustHaze,manmade,seaLakeIce,severeStorms,snow,volcanoes,waterColor,floods,wildfires&l=Reference_Labels_15m,Reference_Features_15m,Coastlines_15m(hidden),IMERG_Precipitation_Rate_30min,IMERG_Precipitation_Rate(hidden),VIIRS_NOAA20_DayNightBand_At_Sensor_Radiance(hidden),VIIRS_NOAA20_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_DayNightBand_At_Sensor_Radiance(hidden),VIIRS_SNPP_DayNightBand_AtSensor_M15(hidden),MODIS_Combined_Flood_3-Day(hidden,disabled=3),MODIS_Combined_Flood_2-Day(hidden,disabled=3),VIIRS_NOAA21_CorrectedReflectance_TrueColor,BlueMarble_NextGeneration(hidden),VIIRS_NOAA20_CorrectedReflectance_TrueColor(hidden),VIIRS_SNPP_CorrectedReflectance_TrueColor(hidden),MODIS_Aqua_CorrectedReflectance_TrueColor(hidden),MODIS_Terra_CorrectedReflectance_TrueColor&lg=true&t=2025-10-02-T21%3A18%3A00Z";
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  int _progress = 0;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
          },
          onProgress: (int progress) {
            // 👇 Update progress (0–100)
            setState(() => _progress = progress);
          },
          onNavigationRequest: (NavigationRequest request) {
            final allowedDomain = Uri.parse(widget.url).host;
            final newDomain = Uri.parse(request.url).host;

            // Allow navigation only within same domain
            if (newDomain == allowedDomain) {
              return NavigationDecision.navigate;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Navigation blocked: $newDomain')),
              );
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ✅ Only back button, no title
        automaticallyImplyLeading: true,
        title: const Text('Natural Events'),
        elevation: 0,
      ),
      body: Column(
        children: [
          if (_progress < 100)
            LinearProgressIndicator(
              value: _progress / 100,
              // color: Colors.blue,
              // backgroundColor: Colors.blue.withOpacity(0.2),
              minHeight: 3,
            ),

          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(), // 👈 Loading indicator
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
