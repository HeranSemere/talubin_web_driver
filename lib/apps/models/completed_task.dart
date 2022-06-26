

import 'package:flutter/material.dart';
import 'package:talu_bin_driver/apps/SQFlite/presist_completed_tasks.dart';

class CompletedTask {
  String? completedDate;
  String? userId;
  String? institutionName;
  String? tBNumber;
  Weight? weight;
  Bin? bin;

  CompletedTask(
      {this.completedDate,
        this.userId,
        this.institutionName,
        this.tBNumber,
        this.weight,
        this.bin});

  CompletedTask.fromJson(Map<String, dynamic> json) {
    completedDate = json['completedDate'];
    userId = json['userId'];
    institutionName = json['institutionName'];
    tBNumber = json['TBNumber'];
    weight = json['weight'] != null ? new Weight.fromJson(json['weight']) : null;
    bin = json['bin'] != null ? new Bin.fromJson(json['bin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completedDate'] = this.completedDate;
    data['userId'] = this.userId;
    data['institutionName'] = this.institutionName;
    data['TBNumber'] = this.tBNumber;
    if (this.weight != null) {
      data['weight'] = this.weight!.toJson();
    }
    if (this.bin != null) {
      data['bin'] = this.bin!.toJson();
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'completedDate': completedDate,
      'userId': userId,
      'institutionName': institutionName,
      'TBNumber': tBNumber,
      'weightBlue': weight!.blue,
      'weightRed': weight!.red,
      'weightOther': weight!.other,
      'long': bin!.location!.long,
      'lat': bin!.location!.lat,
      'institutionId': bin!.institutionId,
      'createdDate': bin!.createdDate,
      'updatedDate': bin!.updatedDate,
      'completedId ': bin!.id,
    };
  }


  Future<void> localise(List<CompletedTask> cts) async{

    var database = await CompletedTasksDatabase().createDB(); 
    await CompletedTasksDatabase().insertCompletedTask(cts, database);

    

  }


}

class Weight {
  Weight({
    this.blue,
    this.red,
    this.other,
  });

  int? blue;
  int? red;
  int? other;

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
    blue: json["blue"].toInt(),
    red: json["red"].toInt(),
    other: json["other"].toInt(),
  );

  Map<String, dynamic> toJson() => {
    "blue": blue,
    "red": red,
    "other": other,
  };
}

class Bin {
  String? tBNumber;
  bool? isActive;
  Location? location;
  String? institutionId;
  String? manufactureDate;
  String? deployedDate;
  String? sn;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  int? size;
  int? price;
  int? compartmentCount;
  String? powerSupply;
  String? processorVersion;
  String? binVersion;
  int? ram;
  String? os;
  Status? status;
  String? id;

  Bin(
      {this.tBNumber,
        this.isActive,
        this.location,
        this.institutionId,
        this.manufactureDate,
        this.deployedDate,
        this.sn,
        this.createdDate,
        this.updatedDate,
        this.createdBy,
        this.size,
        this.price,
        this.compartmentCount,
        this.powerSupply,
        this.processorVersion,
        this.binVersion,
        this.ram,
        this.os,
        this.status,
        this.id});

  Bin.fromJson(Map<String, dynamic> json) {
    tBNumber = json['TBNumber'];
    isActive = json['isActive'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    institutionId = json['institutionId'];
    manufactureDate = json['manufactureDate'];
    deployedDate = json['deployedDate'];
    sn = json['sn'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    createdBy = json['createdBy'];
    size = json['size'];
    price = json['price'];
    compartmentCount = json['compartmentCount'];
    powerSupply = json['powerSupply'];
    processorVersion = json['processorVersion'];
    binVersion = json['binVersion'];
    ram = json['ram'];
    os = json['os'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TBNumber'] = this.tBNumber;
    data['isActive'] = this.isActive;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['institutionId'] = this.institutionId;
    data['manufactureDate'] = this.manufactureDate;
    data['deployedDate'] = this.deployedDate;
    data['sn'] = this.sn;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['createdBy'] = this.createdBy;
    data['size'] = this.size;
    data['price'] = this.price;
    data['compartmentCount'] = this.compartmentCount;
    data['powerSupply'] = this.powerSupply;
    data['processorVersion'] = this.processorVersion;
    data['binVersion'] = this.binVersion;
    data['ram'] = this.ram;
    data['os'] = this.os;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Location {
  double? long;
  double? lat;

  Location({this.long, this.lat});

  Location.fromJson(Map<String, dynamic> json) {
    long = json['long'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long'] = this.long;
    data['lat'] = this.lat;
    return data;
  }
}

class Status {
  Weight? weight;

  Status({this.weight});

  Status.fromJson(Map<String, dynamic> json) {
    weight =
    json['weight'] != null ? new Weight.fromJson(json['weight']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weight != null) {
      data['weight'] = this.weight!.toJson();
    }
    return data;
  }
}