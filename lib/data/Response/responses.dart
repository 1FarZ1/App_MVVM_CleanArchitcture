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

  AuthResponse(this.customer,this.contact);
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseFromJson(json);
  }
  Map<String,dynamic> toJson() {
    return _$AuthResponseToJson(this);
  }
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support ;
  ForgetPasswordResponse(this.support);

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordResponseFromJson(json);
  }
  Map<String,dynamic> toJson() {
    return _$ForgetPasswordResponseToJson(this);
  }
}
// RegisterResponse

// @JsonSerializable()
// class RegisterResponse extends BaseResponse {
//   @JsonKey(name: "username")
//   @JsonKey(name: "countryMobileCode")
//   @JsonKey(name:"email")
  
//   String? username;
//   String? countryMobileCode;

  
//   String? support ;
//   RegisterResponse(this.support);

//   factory RegisterResponse.fromJson(Map<String, dynamic> json) {
//     return _$RegisterResponseFromJson(json);
//   }
//   Map<String,dynamic> toJson() {
//     return _$RegisterResponseToJson(this);
//   }
// }
