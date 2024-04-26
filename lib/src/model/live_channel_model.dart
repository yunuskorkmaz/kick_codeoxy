import 'categories_model.dart';
import 'user_model.dart';

class LiveChannelResponse {
  int? currentPage;
  List<LiveChannelData>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  int? perPage;
  Null prevPageUrl;
  int? to;

  LiveChannelResponse(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to});

  LiveChannelResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <LiveChannelData>[];
      json['data'].forEach((v) {
        data!.add(LiveChannelData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    return data;
  }
}

class LiveChannelData {
  int? id;
  String? slug;
  int? channelId;
  String? sessionTitle;
  bool? isLive;
  String? startTime;
  Null twitchChannel;
  int? duration;
  String? language;
  int? viewerCount;
  Thumbnail? thumbnail;
  int? viewers;
  Channel? channel;
  List<Categories>? categories;

  LiveChannelData(
      {this.id,
      this.slug,
      this.channelId,
      this.sessionTitle,
      this.isLive,
      this.startTime,
      this.twitchChannel,
      this.duration,
      this.language,
      this.viewerCount,
      this.thumbnail,
      this.viewers,
      this.channel,
      this.categories});

  LiveChannelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    channelId = json['channel_id'];
    sessionTitle = json['session_title'];
    isLive = json['is_live'];
    startTime = json['start_time'];
    twitchChannel = json['twitch_channel'];
    duration = json['duration'];
    language = json['language'];
    viewerCount = json['viewer_count'];
    thumbnail = json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null;
    viewers = json['viewers'];
    channel =
        json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['channel_id'] = channelId;
    data['session_title'] = sessionTitle;
    data['is_live'] = isLive;
    data['start_time'] = startTime;
    data['twitch_channel'] = twitchChannel;
    data['duration'] = duration;
    data['language'] = language;
    data['viewer_count'] = viewerCount;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    data['viewers'] = viewers;
    if (channel != null) {
      data['channel'] = channel!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Thumbnail {
  String? srcset;
  String? src;

  Thumbnail({this.srcset, this.src});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    srcset = json['srcset'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['srcset'] = srcset;
    data['src'] = src;
    return data;
  }
}

class Channel {
  int? id;
  int? userId;
  String? slug;
  bool? isBanned;
  String? playbackUrl;
  bool? canHost;
  User? user;

  Channel(
      {this.id,
      this.userId,
      this.slug,
      this.isBanned,
      this.playbackUrl,
      this.canHost,
      this.user});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    slug = json['slug'];
    isBanned = json['is_banned'];
    playbackUrl = json['playback_url'];
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
    data['can_host'] = canHost;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
