import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'model/channel_data_model.dart';
import 'service/followers_manage.dart';
import 'video_player_component.dart';
import 'video_prepare_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? username;

  const ProfileScreen({super.key, required this.username});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ChannelDataResponse? channelData;
  bool isLoading = false;
  bool error = false;
  FollowersManage followersManage = FollowersManage();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var url =
          Uri.parse('https://kick.com/api/v1/channels/${widget.username}');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        var channelData = ChannelDataResponse.fromJson(jsonData);
        setState(() {
          this.channelData = channelData;
        });
      } else {
        print('Hata: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        error = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  String durationToString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      Navigator.of(context).pop();
    }
    double itemWidth = MediaQuery.of(context).size.width / 4;
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: const Color(0xff0b0e0f),
            appBar: AppBar(
              title: Text(channelData!.user!.username ?? "..."),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: InkWell(
                        onTap: () {},
                        child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Image.network(
                              channelData!.bannerImage?.url ??
                                  "https://dbxmjjzl5pc1g.cloudfront.net/94b95aca-436f-422d-8d73-0965e0b8be6c/images/hero-background-2.png",
                              fit: BoxFit.cover,
                            )))),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child:
                                  Image.network(channelData!.user!.profilepic!),
                            )),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(channelData!.user!.username!,
                                style: const TextStyle(fontSize: 20)),
                            Text(
                              "${channelData!.followersCount!.toString()} takipçi",
                              style: const TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
                        FutureBuilder(
                            future:
                                followersManage.isFollower(channelData!.slug!),
                            builder: (builder, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data == true) {
                                  return TextButton(
                                      onPressed: () async {
                                        await followersManage
                                            .removeFollower(channelData!.slug!);
                                        setState(() {});
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          if (states.contains(
                                              MaterialState.focused)) {
                                            return Colors.grey.shade600;
                                          }
                                          return Colors.grey.shade900;
                                        }),
                                        side: MaterialStateProperty.resolveWith(
                                            (states) {
                                          if (states.contains(
                                              MaterialState.focused)) {
                                            return const BorderSide(
                                                width: 2, color: Colors.white);
                                          }
                                          return const BorderSide(
                                              width: 2,
                                              color: Colors.transparent);
                                        }),
                                        shape:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          return RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          );
                                        }),
                                      ),
                                      child: const Text("Takibi bırak"));
                                } else {
                                  return TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          if (states.contains(
                                              MaterialState.focused)) {
                                            return Colors.green.shade600;
                                          }
                                          return Colors.green.shade900;
                                        }),
                                        side: MaterialStateProperty.resolveWith(
                                            (states) {
                                          if (states.contains(
                                              MaterialState.focused)) {
                                            return const BorderSide(
                                                width: 2, color: Colors.white);
                                          }
                                          return const BorderSide(
                                              width: 2,
                                              color: Colors.transparent);
                                        }),
                                        shape:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          return RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          );
                                        }),
                                      ),
                                      onPressed: () async {
                                        await followersManage
                                            .addFollower(channelData!);
                                        setState(() {});
                                      },
                                      child: const Text("Takip et"));
                                }
                              }
                              return const SizedBox(width: 0);
                            }),
                        const SizedBox(width: 10),
                        Visibility(
                          visible: channelData!.livestream != null &&
                              channelData!.livestream?.isLive == true,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.focused)) {
                                  return Colors.red.shade500;
                                }
                                return Colors.red.shade900;
                              }),
                              side: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const BorderSide(
                                      width: 2, color: Colors.white);
                                }
                                return const BorderSide(
                                    width: 2, color: Colors.transparent);
                              }),
                              shape:
                                  MaterialStateProperty.resolveWith((states) {
                                return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                );
                              }),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VideoPlayerComponent(
                                              url: channelData!.playbackUrl!)));
                            },
                            child: const Text("Canlı izle"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Geçmiş yayınlar",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: itemWidth,
                        mainAxisSpacing: 6.0,
                        crossAxisSpacing: 6.0,
                        childAspectRatio: 16 / 13,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var videoItem =
                              channelData!.previousLivestreams![index];
                          return TextButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoPrepareScreen(
                                          uuid: videoItem.video!.uuid!))),
                            },
                            style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                overlayColor: const MaterialStatePropertyAll(
                                    Colors.transparent),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.focused)) {
                                    return Colors.white10;
                                  }
                                  return Colors.transparent;
                                }),
                                shape:
                                    MaterialStateProperty.resolveWith((states) {
                                  return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  );
                                }),
                                side:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.focused)) {
                                    return const BorderSide(
                                        color: Color(0xff53fc18));
                                  }
                                  return const BorderSide(
                                      color: Colors.transparent);
                                })),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          child: Image(
                                            image: NetworkImage(
                                                videoItem.thumbnail!.src!),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        Positioned(
                                          top: 3,
                                          left: 3,
                                          bottom: 3,
                                          right: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 0,
                                                                horizontal: 4),
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Colors
                                                                    .black),
                                                        child: Text(
                                                            durationToString(
                                                                Duration(
                                                                    milliseconds:
                                                                        videoItem
                                                                            .duration!)),
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xff53fc18)))),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                                vertical: 0,
                                                                horizontal: 4),
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Colors
                                                                    .black),
                                                        child: Text(
                                                            DateFormat('dd.MM.yyyy – kk:mm').format(
                                                                DateTime.parse(videoItem.startTime!).add(
                                                                    const Duration(
                                                                        hours:
                                                                            3))),
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                color:
                                                                    Color(0xff53fc18)))),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ]),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 6,
                                      left: 8,
                                      right: 8,
                                      bottom: 4,
                                    ),
                                    child: Text(
                                      videoItem.sessionTitle!,
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ]),
                          );
                        },
                        childCount:
                            channelData!.previousLivestreams!.length ?? 0,
                      ),
                    )),
              ],
            ),
          );
  }
}
