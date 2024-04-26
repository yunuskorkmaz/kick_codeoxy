import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/channel_data_model.dart';

class FollowersManage {
  Future<List<ChannelDataResponse>> getFollowers() async {
    var perfs = await SharedPreferences.getInstance();
    var followers = perfs.getStringList('followers') ?? [];

    List<ChannelDataResponse> searchChannels = [];

    for (var followersItem in followers) {
      Map<String, dynamic> jsonData = jsonDecode(followersItem);

      var item = ChannelDataResponse.fromJson(jsonData);
      searchChannels.add(item);
    }
    return searchChannels;
  }

  Future<void> addFollower(ChannelDataResponse follow) async {
    var perfs = await SharedPreferences.getInstance();
    var followers = perfs.getStringList('followers') ?? [];
    followers.add(jsonEncode(follow));
    perfs.setStringList('followers', followers);
  }

  Future<void> removeFollower(String username) async {
    var perfs = await SharedPreferences.getInstance();
    var followers = perfs.getStringList('followers') ?? [];

    List<ChannelDataResponse> followersList = [];

    for (var followersItem in followers) {
      Map<String, dynamic> jsonData = jsonDecode(followersItem);
      var item = ChannelDataResponse.fromJson(jsonData);
      if (item.slug != username) {
        followersList.add(item);
      }
    }
    perfs.setStringList(
        'followers', followersList.map((e) => jsonEncode(e)).toList());
  }

  Future<bool> isFollower(String username) async {
    var perfs = await SharedPreferences.getInstance();
    var followers = perfs.getStringList('followers') ?? [];

    bool isFollower = false;

    for (var followersItem in followers) {
      Map<String, dynamic> jsonData = jsonDecode(followersItem);

      var item = ChannelDataResponse.fromJson(jsonData);

      if (item.slug == username) {
        isFollower = true;
        break;
      }
    }
    return isFollower;
  }
}
