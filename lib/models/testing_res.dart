class TestingRes {
  int? code;
  String? status;
  String? message;
  List<Data>? data;

  TestingRes({this.code, this.status, this.message, this.data});

  TestingRes.fromJson(Map<String, dynamic> json) {
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
  List<Testingcenters>? testingcenters;
  List<Cities>? cities;

  Data(
      {this.id,
      this.name,
      this.mask,
      this.code,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.testingcenters,
      this.cities});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mask = json['mask'];
    code = json['code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['testingcenters'] != null) {
      testingcenters = <Testingcenters>[];
      json['testingcenters'].forEach((v) {
        testingcenters!.add(new Testingcenters.fromJson(v));
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
    if (this.testingcenters != null) {
      data['testingcenters'] =
          this.testingcenters!.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Testingcenters {
  int? id;
  int? regionId;
  String? name;
  String? location;
  String? duration;
  String? workingHours;
  String? contact;
  int? standardPrice;
  int? premiumPrice;
  String? mask;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  Testingcenters(
      {this.id,
      this.regionId,
      this.name,
      this.location,
      this.duration,
      this.workingHours,
      this.contact,
      this.standardPrice,
      this.premiumPrice,
      this.mask,
      this.status,
      this.createdAt,
      this.updatedAt});

  Testingcenters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regionId = json['region_id'];
    name = json['name'];
    location = json['location'];
    duration = json['duration'];
    workingHours = json['working_hours'];
    contact = json['contact'];
    standardPrice = json['standard_price'];
    premiumPrice = json['premium_price'];
    mask = json['mask'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['region_id'] = this.regionId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['duration'] = this.duration;
    data['working_hours'] = this.workingHours;
    data['contact'] = this.contact;
    data['standard_price'] = this.standardPrice;
    data['premium_price'] = this.premiumPrice;
    data['mask'] = this.mask;
    data['status'] = this.status;
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