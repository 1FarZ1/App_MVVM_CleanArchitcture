// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

//TODO: mnich fahm mlih had lpart ida chft had todo n3awd nrevisi had part t3 tcriyi fromjson tojson  we blablabla
@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "NumberofNotifications")
  int? numberofNotifications;

  CustomerResponse(this.id, this.name, this.numberofNotifications);
  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    return _$CustomerResponseFromJson(json);
  }
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.phone, this.email, this.link);
  factory ContactsResponse.fromJson(Map<String, dynamic> json) {
    return _$ContactsResponseFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthResponse extends BaseResponse {
  @JsonKey(name: "Customer")
  CustomerResponse? customer;

  @JsonKey(name: "Contacts")
  ContactsResponse? contact;

  AuthResponse(this.customer, this.contact);
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$AuthResponseToJson(this);
  }
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;
  ForgetPasswordResponse(this.support);

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordResponseFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$ForgetPasswordResponseToJson(this);
  }
}

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "imageurl")
  String? imageurl;
  ServiceResponse(this.id, this.title, this.imageurl);

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return _$ServiceResponseFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$ServiceResponseToJson(this);
  }
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "link")
  String? link;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "imageurl")
  String? imageurl;
  BannerResponse(this.id, this.link, this.title, this.imageurl);

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return _$BannerResponseFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$BannerResponseToJson(this);
  }
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "imageurl")
  String? imageurl;
  StoreResponse(this.id, this.title, this.imageurl);

  factory StoreResponse.fromJson(Map<String, dynamic> json) {
    return _$StoreResponseFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$StoreResponseToJson(this);
  }
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "Services")
  List<ServiceResponse>? services;

  @JsonKey(name: "Banners")
  List<BannerResponse>? banners;

  @JsonKey(name: "Stores")
  List<StoreResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) {
    return _$HomeDataResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HomeDataResponseToJson(this);
  }
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: "data")
  HomeDataResponse? data;

  HomeResponse(this.data);

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return _$HomeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HomeResponseToJson(this);
  }
}
