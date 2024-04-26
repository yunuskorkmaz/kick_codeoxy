import 'user_model.dart';

class SearchResponse {
  List<SearchChannels>? channels;

  SearchResponse({this.channels});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['channels'] != null) {
      channels = <SearchChannels>[];
      json['channels'].forEach((v) {
        channels!.add(SearchChannels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (channels != null) {
      data['channels'] = channels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchChannels {
  int? id;
  int? userId;
  String? slug;
  bool? isBanned;
  String? playbackUrl;
  bool? vodEnabled;
  bool? subscriptionEnabled;
  bool? isLive;
  int? followersCount;
  int? viewerCount;
  String? lastActivityAt;
  bool? following;
  bool? subscription;
  bool? canHost;
  User? user;

  SearchChannels({
    this.id,
    this.userId,
    this.slug,
    this.isBanned,
    this.playbackUrl,
    this.vodEnabled,
    this.subscriptionEnabled,
    this.isLive,
    this.followersCount,
    this.viewerCount,
    this.lastActivityAt,
    this.following,
    this.subscription,
    this.canHost,
    this.user,
  });

  SearchChannels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    slug = json['slug'];
    isBanned = json['is_banned'];
    playbackUrl = json['playback_url'];
    vodEnabled = json['vod_enabled'];
    subscriptionEnabled = json['subscription_enabled'];
    isLive = json['is_live'];
    followersCount = json['followers_count'];
    viewerCount = json['viewer_count'];
    lastActivityAt = json['last_activity_at'];
    following = json['following'];
    subscription = json['subscription'];
    isLive = json['isLive'];
    canHost = json['can_host'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['slug'] = slug;
    data['is_banned'] = isBanned;
    data['playback_url'] = playbackUrl;
    data['vod_enabled'] = vodEnabled;
    data['subscription_enabled'] = subscriptionEnabled;
    data['is_live'] = isLive;
    data['followers_count'] = followersCount;
    data['viewer_count'] = viewerCount;
    data['last_activity_at'] = lastActivityAt;
    data['userId'] = userId;
    data['following'] = following;
    data['subscription'] = subscription;

    data['can_host'] = canHost;
    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }
}
