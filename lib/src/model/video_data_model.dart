import 'live_channel_model.dart';
import 'categories_model.dart';

class VideoData {
  int? id;
  int? liveStreamId;

  String? createdAt;
  String? updatedAt;
  String? uuid;
  int? views;
  String? source;
  Livestream? livestream;

  VideoData(
      {this.id,
      this.liveStreamId,
      this.createdAt,
      this.updatedAt,
      this.uuid,
      this.views,
      this.source,
      this.livestream});

  VideoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    liveStreamId = json['live_stream_id'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    uuid = json['uuid'];
    views = json['views'];
    source = json['source'];
    livestream = json['livestream'] != null
        ? Livestream.fromJson(json['livestream'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['live_stream_id'] = liveStreamId;

    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['uuid'] = uuid;
    data['views'] = views;
    data['source'] = source;
    if (livestream != null) {
      data['livestream'] = livestream!.toJson();
    }
    return data;
  }
}

class Livestream {
  int? id;
  String? slug;
  int? channelId;
  String? createdAt;
  String? sessionTitle;
  bool? isLive;
  Null riskLevelId;
  String? startTime;
  Null source;
  Null twitchChannel;
  int? duration;
  String? language;
  bool? isMature;
  int? viewerCount;
  String? thumbnail;
  Channel? channel;
  List<Categories>? categories;

  Livestream(
      {this.id,
      this.slug,
      this.channelId,
      this.createdAt,
      this.sessionTitle,
      this.isLive,
      this.riskLevelId,
      this.startTime,
      this.source,
      this.twitchChannel,
      this.duration,
      this.language,
      this.isMature,
      this.viewerCount,
      this.thumbnail,
      this.channel,
      this.categories});

  Livestream.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    channelId = json['channel_id'];
    createdAt = json['created_at'];
    sessionTitle = json['session_title'];
    isLive = json['is_live'];
    riskLevelId = json['risk_level_id'];
    startTime = json['start_time'];
    source = json['source'];
    twitchChannel = json['twitch_channel'];
    duration = json['duration'];
    language = json['language'];
    isMature = json['is_mature'];
    viewerCount = json['viewer_count'];
    thumbnail = json['thumbnail'];
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
    data['created_at'] = createdAt;
    data['session_title'] = sessionTitle;
    data['is_live'] = isLive;
    data['risk_level_id'] = riskLevelId;
    data['start_time'] = startTime;
    data['source'] = source;
    data['twitch_channel'] = twitchChannel;
    data['duration'] = duration;
    data['language'] = language;
    data['is_mature'] = isMature;
    data['viewer_count'] = viewerCount;
    data['thumbnail'] = thumbnail;
    if (channel != null) {
      data['channel'] = channel!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
