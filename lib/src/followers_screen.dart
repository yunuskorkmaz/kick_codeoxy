import 'package:flutter/material.dart';

import 'model/channel_data_model.dart';
import 'profile_screen.dart';
import 'service/followers_manage.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  List<ChannelDataResponse> followersList = [];

  Future<void> getFollowers() async {
    var followersManager = FollowersManage();
    var list = await followersManager.getFollowers();
    setState(() {
      followersList = list;
    });
  }

  @override
  void initState() {
    super.initState();
    getFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0b0e0f),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Center(
                child: TextButton(
                  child: const Text("Yenile"),
                  onPressed: () {
                    getFollowers();
                  },
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 16 / 7,
                  children: followersList
                      .map((e) => TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(10)),
                                overlayColor: const MaterialStatePropertyAll(
                                    Colors.transparent),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.focused)) {
                                    return Colors.white10;
                                  }
                                  return Colors.transparent;
                                })
                                // const MaterialStatePropertyAll(
                                //     Colors.transparent)
                                ,
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
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileScreen(username: e.slug!),
                                  ))
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 75,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(80)),
                                          child: Image.network(e
                                                  .user?.profilepic ??
                                              e.user?.profilePic ??
                                              "https://dbxmjjzl5pc1g.cloudfront.net/4dae1adb-1d6b-4fdf-aa8c-d4b0f3bf8568/images/user-profile-pic.png"),
                                        )),
                                    const SizedBox(width: 10),
                                    Flexible(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: Text(
                                            e.user?.username! ?? e.slug! ?? "",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ),
                                        Text(
                                            "${e.followersCount?.toString()} takipçi",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white54,
                                            )),
                                      ],
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          )),
    );
  }
}
