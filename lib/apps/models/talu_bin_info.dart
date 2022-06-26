// To parse this JSON data, do
//
//     final taluBinInfo = taluBinInfoFromJson(jsonString);

import 'dart:convert';

TaluBinInfo taluBinInfoFromJson(String str) =>
    TaluBinInfo.fromJson(json.decode(str));

String taluBinInfoToJson(TaluBinInfo data) => json.encode(data.toJson());

class TaluBinInfo {
  TaluBinInfo({
    this.bins,
  });

  List<BinElement>? bins;

  factory TaluBinInfo.fromJson(Map<String, dynamic> json) => TaluBinInfo(
        bins: List<BinElement>.from(
            json["bins"].map((x) => BinElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bins": List<dynamic>.from(bins!.map((x) => x.toJson())),
      };
}

class BinElement {
  BinElement({
    this.bin,
    this.institution,
  });

  BinBin? bin;
  Institution? institution;

  factory BinElement.fromJson(Map<String, dynamic> json) => BinElement(
        bin: BinBin.fromJson(json["bin"]),
        institution: Institution.fromJson(json["institution"]),
      );

  Map<String, dynamic> toJson() => {
        "bin": bin!.toJson(),
        "institution": institution!.toJson(),
      };
}

class BinBin {
  BinBin({
    this.tbNumber,
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
    this.ram,
    this.os,
    this.status,
    this.id,
    this.institution,
    this.powerVoltage,
  });

  String? tbNumber;
  bool? isActive;
  BinLocation? location;
  String? institutionId;
  DateTime? manufactureDate;
  DateTime? deployedDate;
  String? sn;
  DateTime? createdDate;
  DateTime? updatedDate;
  String? createdBy;
  int? size;
  int? price;
  int? compartmentCount;
  String? powerSupply;
  String? processorVersion;
  int? ram;
  String? os;
  Status? status;
  String? id;
  String? institution;
  String? powerVoltage;

  factory BinBin.fromJson(Map<String, dynamic> json) => BinBin(
        tbNumber: json["TBNumber"],
        isActive: json["isActive"],
        location: BinLocation.fromJson(json["location"]),
        institutionId: json["institutionId"],
        manufactureDate: DateTime.parse(json["manufactureDate"]),
        deployedDate: DateTime.parse(json["deployedDate"]),
        sn: json["sn"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
        createdBy: json["createdBy"],
        size: json["size"],
        price: json["price"],
        compartmentCount: json["compartmentCount"],
        powerSupply: json["powerSupply"],
        processorVersion: json["processorVersion"],
        ram: json["ram"],
        os: json["os"],
        status: Status.fromJson(json["status"]),
        id: json["id"],
        institution: json["institution"] == null ? null : json["institution"],
        powerVoltage:
            json["powerVoltage"] == null ? null : json["powerVoltage"],
      );

  Map<String, dynamic> toJson() => {
        "TBNumber": tbNumber,
        "isActive": isActive,
        "location": location!.toJson(),
        "institutionId": institutionId,
        "manufactureDate": manufactureDate!.toIso8601String(),
        "deployedDate": deployedDate!.toIso8601String(),
        "sn": sn,
        "createdDate": createdDate!.toIso8601String(),
        "updatedDate": updatedDate!.toIso8601String(),
        "createdBy": createdBy,
        "size": size,
        "price": price,
        "compartmentCount": compartmentCount,
        "powerSupply": powerSupply,
        "processorVersion": processorVersion,
        "ram": ram,
        "os": os,
        "status": status!.toJson(),
        "id": id,
        "institution": institution == null ? null : institution,
        "powerVoltage": powerVoltage == null ? null : powerVoltage,
      };
}

class BinLocation {
  BinLocation({
    this.lati,
    this.long,
    this.lat,
  });

  double? lati;
  double? long;
  double? lat;

  factory BinLocation.fromJson(Map<String, dynamic> json) => BinLocation(
        lati: json["lati"] == null ? null : json["lati"].toDouble(),
        long: json["long"].toDouble(),
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lati": lati == null ? null : lati,
        "long": long,
        "lat": lat == null ? null : lat,
      };
}

class Status {
  Status({
    this.weight,
  });

  Weight? weight;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        weight: Weight.fromJson(json["weight"]),
      );

  Map<String, dynamic> toJson() => {
        "weight": weight!.toJson(),
      };
}

class Weight {
  Weight({
    this.blue,
    this.red,
    this.other,
  });

  int? blue;
  double? red;
  int? other;

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        blue: json["blue"],
        red: json["red"].toDouble(),
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "blue": blue,
        "red": red,
        "other": other,
      };
}

class Institution {
  Institution({
    this.name,
    this.email,
    this.code,
    this.address,
    this.bins,
    this.location,
    this.id,
  });

  String? name;
  String? email;
  String? code;
  String? address;
  List<String>? bins;
  InstitutionLocation? location;
  String? id;

  factory Institution.fromJson(Map<String, dynamic> json) => Institution(
        name: json["name"],
        email: json["email"],
        code: json["code"],
        address: json["address"],
        bins: List<String>.from(json["bins"].map((x) => x)),
        location: InstitutionLocation.fromJson(json["location"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "code": code,
        "address": address,
        "bins": List<dynamic>.from(bins!.map((x) => x)),
        "location": location!.toJson(),
        "id": id,
      };
}

class InstitutionLocation {
  InstitutionLocation();

  factory InstitutionLocation.fromJson(Map<String, dynamic> json) =>
      InstitutionLocation();

  Map<String, dynamic> toJson() => {};
}
