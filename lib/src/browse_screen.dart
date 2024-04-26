import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'model/search_model.dart';
import 'profile_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  SearchResponse? searchedData;
  FocusNode searchFocusNode = FocusNode();
  FocusNode searchFocusNode2 = FocusNode();
  FocusNode keyboardFocusNode = FocusNode();
  bool isLoading = false;
  String search = "";
  var textController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void searchData(String value) async {
    setState(() {
      isLoading = true;
    });
    try {
      var url = Uri.parse('https://kick.com/api/search?searched_word=$value');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        var channelData = SearchResponse.fromJson(jsonData);
        setState(() {
          searchedData = channelData;
        });
        searchFocusNode.unfocus();
      } else {
        print('Hata: ${response.statusCode}');
      }
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> harfler = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
      "_",
      "←",
      "✓"
    ];
    return Container(
      decoration: const BoxDecoration(color: Color(0xff0b0e0f)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  TextField(
                    focusNode: searchFocusNode,
                    controller: textController,
                    canRequestFocus: false,
                    readOnly: true,
                    onSubmitted: (value) {
                      searchData(value);
                      searchFocusNode.unfocus();
                      searchFocusNode2.requestFocus();
                    },
                    decoration: const InputDecoration(
                        hoverColor: Color(0xff53fc18),
                        hintText: "Arama...",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            gapPadding: 0.2)),
                  ),
                  Expanded(
                      child: GridView.count(
                          crossAxisCount: 6,
                          childAspectRatio: 1,
                          children: harfler.map((harf) {
                            return TextButton(
                              onPressed: () {
                                var _newSearch = search;
                                if (!["✓", "←", "_"].contains(harf)) {
                                  _newSearch = _newSearch + harf.toLowerCase();
                                } else {
                                  switch (harf) {
                                    case "✓":
                                      searchData(search);
                                      break;
                                    case "←":
                                      _newSearch = _newSearch.substring(
                                          0, _newSearch.length - 1);
                                      break;
                                    case "_":
                                      _newSearch = _newSearch + " ";
                                      break;
                                  }
                                }
                                setState(() {
                                  search = _newSearch;
                                });
                                textController.text = _newSearch;
                              },
                              child: Text(
                                harf,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            );
                          }).toList()))
                ],
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
                flex: 6,
                child: Column(children: [
                  TextButton(
                    onPressed: () => {print("")},
                    focusNode: searchFocusNode2,
                    child: const Text("Arama Sonuçları"),
                  ),
                  Expanded(
                      child: isLoading == false
                          ? GridView.count(
                              crossAxisCount: 3,
                              childAspectRatio: 16 / 7,
                              children: searchedData != null
                                  ? searchedData!.channels!
                                      .map((e) => TextButton(
                                            style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.all(
                                                            10)),
                                                overlayColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith((states) {
                                                  if (states.contains(
                                                      MaterialState.focused)) {
                                                    return Colors.white10;
                                                  }
                                                  return Colors.transparent;
                                                })
                                                // const MaterialStatePropertyAll(
                                                //     Colors.transparent)
                                                ,
                                                shape: MaterialStateProperty
                                                    .resolveWith((states) {
                                                  return RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  );
                                                }),
                                                side: MaterialStateProperty
                                                    .resolveWith((states) {
                                                  if (states.contains(
                                                      MaterialState.focused)) {
                                                    return const BorderSide(
                                                        color:
                                                            Color(0xff53fc18));
                                                  }
                                                  return const BorderSide(
                                                      color:
                                                          Colors.transparent);
                                                })),
                                            onPressed: () => {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen(
                                                            username: e.slug!),
                                                  ))
                                            },
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 75,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          80)),
                                                          child: Image.network(e
                                                                  .user!
                                                                  .profilePic ??
                                                              "https://dbxmjjzl5pc1g.cloudfront.net/4dae1adb-1d6b-4fdf-aa8c-d4b0f3bf8568/images/user-profile-pic.png"),
                                                        )),
                                                    const SizedBox(width: 10),
                                                    Flexible(
                                                        child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 4),
                                                          child: Text(
                                                            e.user!.username!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          '${e.followersCount!.toString() ?? "0"} takipçi',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                        e.isLive == true
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .red,
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          0,
                                                                      horizontal:
                                                                          4),
                                                                  child:
                                                                      const Text(
                                                                          "Live"),
                                                                ))
                                                            : const SizedBox(
                                                                width: 0,
                                                                height: 0,
                                                              )
                                                      ],
                                                    ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                      .toList()
                                  : [],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ))
                ])),
          ],
        ),
      ),
    );
  }
}
