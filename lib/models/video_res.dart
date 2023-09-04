class VideosRes {
  int? code;
  String? status;
  String? message;
  List<VideoCategory>? data;

  VideosRes({this.code, this.status, this.message, this.data});

  VideosRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VideoCategory>[];
      json['data'].forEach((v) {
        data!.add(new VideoCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoCategory {
  String? name;
  String? description;
  List<Video>? videos;

  VideoCategory({this.name, this.description, this.videos});

  VideoCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['videos'] != null) {
      videos = <Video>[];
      json['videos'].forEach((v) {
        videos!.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video{
  int? id;
  String? title;
  String? description;
  String? videoUrl;
  String? mLink;
  String? mask;
  int? createdBy;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? categoryId;

  Video(
      {this.id,
      this.title,
      this.description,
      this.videoUrl,
      this.mLink,
      this.mask,
      this.createdBy,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.categoryId});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    videoUrl = json['video_url'];
    mLink = json['mlink'];
    mask = json['mask'];
    createdBy = json['created_by'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['video_url'] = this.videoUrl;
    data['mlink'] = this.mLink;
    data['mask'] = this.mask;
    data['created_by'] = this.createdBy;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    return data;
  }
}