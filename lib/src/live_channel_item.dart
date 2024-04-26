import 'package:flutter/material.dart';

import 'model/live_channel_model.dart';
import 'profile_screen.dart';

class LiveChannelItem extends StatelessWidget {
  const LiveChannelItem({super.key, required this.channelData});

  final LiveChannelData channelData;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.focused)) {
                    return Colors.white10;
                  }
                  return Colors.transparent;
                }),
                shape: MaterialStateProperty.resolveWith((states) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  );
                }),
                side: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.focused)) {
                    return const BorderSide(color: Color(0xff53fc18));
                  }
                  return const BorderSide(color: Colors.transparent);
                })),
            onPressed: () => {
                  // GoRouter.of(context).go("/video/${channel.channel!.user!.username!}"),
                  if (channelData.channel!.slug != null)
                    {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => VideoScreen(
                      //               channelName: channelData.channel!.slug,
                      //             )))
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                    username: channelData.channel!.slug,
                                  )))
                    }
                },
            child: Column(children: [
              Stack(alignment: Alignment.topLeft, children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: Image(
                    image: NetworkImage(channelData.thumbnail!.src!),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 3,
                  left: 3,
                  bottom: 3,
                  right: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 4),
                                decoration:
                                    const BoxDecoration(color: Colors.black),
                                child: const Text("CANLI",
                                    style: TextStyle(
                                        color: Color(0xff53fc18),
                                        fontSize: 11))),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 4),
                                decoration:
                                    const BoxDecoration(color: Colors.black),
                                child: Text(
                                  "● ${channelData.viewerCount!}",
                                  style: const TextStyle(
                                      color: Color(0xff53fc18), fontSize: 12),
                                )),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: 25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                    channelData.channel!.user!.profilepic!),
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(channelData.channel!.user!.username!),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        channelData.sessionTitle!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(channelData.categories![0].name!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color.fromARGB(144, 255, 255, 255),
                          )),
                    ],
                  ))
            ])));
  }
}
