import 'categories_model.dart';
import 'user_model.dart';

class ChannelDataResponse {
  int? id;
  int? userId;
  String? slug;
  bool? isBanned;
  String? playbackUrl;
  int? followersCount;
  BannerImage? bannerImage;
  Livestream? livestream;
  User? user;
  List<PreviousLivestreams>? previousLivestreams;

  ChannelDataResponse({
    this.id,
    this.userId,
    this.slug,
    this.isBanned,
    this.playbackUrl,
    this.followersCount,
    this.bannerImage,
    this.livestream,
    this.user,
    this.previousLivestreams,
  });

  ChannelDataResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    slug = json['slug'];
    isBanned = json['is_banned'];
    playbackUrl = json['playback_url'];
    followersCount = json['followersCount'];
    bannerImage = json['banner_image'] != null
        ? BannerImage.fromJson(json['banner_image'])
        : null;
    livestream = json['livestream'] != null
        ? Livestream.fromJson(json['livestream'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;

    if (json['previous_livestreams'] != null) {
      previousLivestreams = <PreviousLivestreams>[];
      json['previous_livestreams'].forEach((v) {
        previousLivestreams!.add(PreviousLivestreams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['slug'] = slug;
    data['is_banned'] = isBanned;
    data['playback_url'] = playbackUrl;

    data['followersCount'] = followersCount;

    if (bannerImage != null) {
      data['banner_image'] = bannerImage!.toJson();
    }
    if (livestream != null) {
      data['livestream'] = livestream!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (previousLivestreams != null) {
      data['previous_livestreams'] =
          previousLivestreams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BadgeImage {
  String? srcset;
  String? src;

  BadgeImage({this.srcset, this.src});

  BadgeImage.fromJson(Map<String, dynamic> json) {
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

class BannerImage {
  String? responsive;
  String? url;

  BannerImage({this.responsive, this.url});

  BannerImage.fromJson(Map<String, dynamic> json) {
    responsive = json['responsive'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['responsive'] = responsive;
    data['url'] = url;
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
  String? startTime;
  int? duration;
  String? language;
  bool? isMature;
  int? viewerCount;
  BadgeImage? thumbnail;
  int? viewers;
  List<Categories>? categories;

  Livestream({
    this.id,
    this.slug,
    this.channelId,
    this.createdAt,
    this.sessionTitle,
    this.isLive,
    this.startTime,
    this.duration,
    this.language,
    this.isMature,
    this.viewerCount,
    this.thumbnail,
    this.viewers,
    this.categories,
  });

  Livestream.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    channelId = json['channel_id'];
    createdAt = json['created_at'];
    sessionTitle = json['session_title'];
    isLive = json['is_live'];

    startTime = json['start_time'];

    duration = json['duration'];
    language = json['language'];
    isMature = json['is_mature'];
    viewerCount = json['viewer_count'];
    thumbnail = json['thumbnail'] != null
        ? BadgeImage.fromJson(json['thumbnail'])
        : null;
    viewers = json['viewers'];
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
    data['start_time'] = startTime;
    data['duration'] = duration;
    data['language'] = language;
    data['is_mature'] = isMature;
    data['viewer_count'] = viewerCount;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    data['viewers'] = viewers;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class PreviousLivestreams {
  int? id;
  String? slug;
  int? channelId;
  String? createdAt;
  String? sessionTitle;
  bool? isLive;

  String? startTime;

  int? duration;
  String? language;
  bool? isMature;
  int? viewerCount;
  BadgeImage? thumbnail;
  int? views;
  List<Categories>? categories;
  Video? video;

  PreviousLivestreams(
      {this.id,
      this.slug,
      this.channelId,
      this.createdAt,
      this.sessionTitle,
      this.isLive,
      this.startTime,
      this.duration,
      this.language,
      this.isMature,
      this.viewerCount,
      this.thumbnail,
      this.views,
      this.categories,
      this.video});

  PreviousLivestreams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    channelId = json['channel_id'];
    createdAt = json['created_at'];
    sessionTitle = json['session_title'];
    isLive = json['is_live'];
    startTime = json['start_time'];
    duration = json['duration'];
    language = json['language'];
    isMature = json['is_mature'];
    viewerCount = json['viewer_count'];
    thumbnail = json['thumbnail'] != null
        ? BadgeImage.fromJson(json['thumbnail'])
        : null;
    views = json['views'];

    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['channel_id'] = channelId;
    data['created_at'] = createdAt;
    data['session_title'] = sessionTitle;
    data['is_live'] = isLive;
    data['start_time'] = startTime;
    data['duration'] = duration;
    data['language'] = language;
    data['is_mature'] = isMature;
    data['viewer_count'] = viewerCount;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    data['views'] = views;

    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (video != null) {
      data['video'] = video!.toJson();
    }
    return data;
  }
}

class Video {
  int? id;
  int? liveStreamId;
  String? createdAt;
  String? updatedAt;
  String? uuid;
  int? views;
  Null deletedAt;

  Video(
      {this.id,
      this.liveStreamId,
      this.createdAt,
      this.updatedAt,
      this.uuid,
      this.views,
      this.deletedAt});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    liveStreamId = json['live_stream_id'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    uuid = json['uuid'];
    views = json['views'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['live_stream_id'] = liveStreamId;

    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['uuid'] = uuid;
    data['views'] = views;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
