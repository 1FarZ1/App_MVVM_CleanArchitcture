import 'package:providerlearn/data/Response/responses.dart';
import 'package:providerlearn/data/Response/responses.dart';

import 'package:providerlearn/domaine/models/Models.dart';
import "package:providerlearn/app/extensions.dart";

import '../../app/consts.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomaine() {
    return Customer(
        id: this?.id.orEmpty() ?? Constants.Empty,
        name: this?.name.orEmpty() ?? Constants.Empty,
        numberofNotifications:
            this?.numberofNotifications.orZero() ?? Constants.Zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomaine() {
    return Contacts(
        phone: this?.phone.orEmpty() ?? Constants.Empty,
        email: this?.email.orEmpty() ?? Constants.Empty,
        link: this?.link.orEmpty() ?? Constants.Empty);
  }
}

extension AuthResponseMapper on AuthResponse? {
  Auth toDomaine() {
    return Auth(
        customer: this?.customer.toDomaine(),
        contacts: this?.contact.toDomaine());
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse? {
  String toDomaine() {
    return this?.support.orEmpty() ?? Constants.Empty;
  }
}

extension ServiceMappper on ServiceResponse? {
  Service toDomaine() {
    return Service(
        id: this?.id ?? Constants.Empty,
        title: this?.title ?? Constants.Empty,
        imageUrl: this?.imageurl ?? Constants.Empty);
  }
}

extension BannerMappper on BannerResponse? {
  Banner toDomaine() {
    return Banner(
        id: this?.id ?? Constants.Empty,
        link: this?.link ?? Constants.Empty,
        title: this?.title ?? Constants.Empty,
        imageUrl: this?.imageurl ?? Constants.Empty);
  }
}

extension StoreMappper on StoreResponse? {
  Store toDomaine() {
    return Store(
        id: this?.id ?? Constants.Empty,
        title: this?.title ?? Constants.Empty,
        imageUrl: this?.imageurl ?? Constants.Empty);
  }
}

extension HomeDataMapper on HomeDataResponse? {
  HomeData toDomaine() {
    return HomeData(
        services: this?.services?.map((e) => e.toDomaine()).toList() ?? [],
        banners: this?.banners,
        stores: this?.stores);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomaine() {
    return HomeObject(
      this?.data ?? 
    );
  }
}
