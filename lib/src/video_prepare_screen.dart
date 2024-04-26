import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/video_data_model.dart';
import 'video_player_component.dart';

class VideoPrepareScreen extends StatefulWidget {
  final String uuid;

  const VideoPrepareScreen({super.key, required this.uuid});

  @override
  State<VideoPrepareScreen> createState() => _VideoPrepareScreenState();
}

class _VideoPrepareScreenState extends State<VideoPrepareScreen> {
  VideoData? videoData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      var url = Uri.parse('https://kick.com/api/v1/video/${widget.uuid}');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        var videoResponse = VideoData.fromJson(jsonData);
        setState(() {
          videoData = videoResponse;
        });
      } else {
        print('Hata: ${response.statusCode}');
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == false && videoData == null) {
      Navigator.pop(context);
    }

    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : VideoPlayerComponent(
            url: videoData!.source!,
            isLive: false,
          );
  }
}
