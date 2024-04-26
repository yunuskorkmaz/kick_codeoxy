import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'live_channel_item.dart';
import 'model/live_channel_model.dart';

class LivesScreen extends StatefulWidget {
  const LivesScreen({super.key});

  @override
  State<LivesScreen> createState() => _LivesScreenState();
}

class _LivesScreenState extends State<LivesScreen> {
  List<LiveChannelData> liveChannelsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      var url = Uri.parse('https://kick.com/stream/featured-livestreams/tr');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        var liveChannels = LiveChannelResponse.fromJson(jsonData);
        setState(() {
          liveChannelsData = liveChannels.data!;
        });
        print(liveChannels);
      } else {
        print('Hata: ${response.statusCode}');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(color: Color(0xff0b0e0f)),
        child: Column(children: [
          TextButton(
              onPressed: () => {fetchData()}, child: const Text('Yenile')),
          Expanded(
              child: GridView.count(
            crossAxisCount: 5,
            childAspectRatio: 1,
            children: liveChannelsData
                .map((e) => LiveChannelItem(channelData: e))
                .toList(),
          ))
        ]));
  }
}
