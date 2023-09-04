class VaccinationRes {
  int? code;
  String? status;
  String? message;
  List<Data>? data;

  VaccinationRes({this.code, this.status, this.message, this.data});

  VaccinationRes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? name;
  String? mask;
  String? code;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Districtlist>? districtlist;
  List<Cities>? cities;

  Data(
      {this.id,
      this.name,
      this.mask,
      this.code,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.districtlist,
      this.cities});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mask = json['mask'];
    code = json['code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['districtlist'] != null) {
      districtlist = <Districtlist>[];
      json['districtlist'].forEach((v) {
        districtlist!.add(new Districtlist.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mask'] = this.mask;
    data['code'] = this.code;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.districtlist != null) {
      data['districtlist'] = this.districtlist!.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Districtlist {
  int? id;
  int? regionId;
  String? name;
  String? mask;
  String? createdAt;
  String? updatedAt;
  int? count;
  List<Centerlist>? centerlist;

  Districtlist(
      {this.id,
      this.regionId,
      this.name,
      this.mask,
      this.createdAt,
      this.updatedAt,
      this.count,
      this.centerlist});

  Districtlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regionId = json['region_id'];
    name = json['name'];
    mask = json['mask'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    count = json['count'];
    if (json['centerlist'] != null) {
      centerlist = <Centerlist>[];
      json['centerlist'].forEach((v) {
        centerlist!.add(new Centerlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['region_id'] = this.regionId;
    data['name'] = this.name;
    data['mask'] = this.mask;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['count'] = this.count;
    if (this.centerlist != null) {
      data['centerlist'] = this.centerlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Centerlist {
  int? id;
  int? districtId;
  String? name;
  String? mask;
  String? createdAt;
  String? updatedAt;

  Centerlist(
      {this.id,
      this.districtId,
      this.name,
      this.mask,
      this.createdAt,
      this.updatedAt});

  Centerlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    name = json['name'];
    mask = json['mask'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district_id'] = this.districtId;
    data['name'] = this.name;
    data['mask'] = this.mask;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Cities {
  int? id;
  String? name;
  String? region;
  int? status;
  String? createdAt;
  String? updatedAt;

  Cities(
      {this.id,
      this.name,
      this.region,
      this.status,
      this.createdAt,
      this.updatedAt});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    region = json['region'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['region'] = this.region;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}