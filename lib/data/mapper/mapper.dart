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
        id: this?.id.orZero() ?? Constants.Zero,
        title: this?.title.orEmpty() ?? Constants.Empty,
        imageUrl: this?.imageurl.orEmpty() ?? Constants.Empty);
  }
}

extension BannerMappper on BannerResponse? {
  Banner toDomaine() {
    return Banner(
        id: this?.id.orZero() ?? Constants.Zero,
        link: this?.link.orEmpty() ?? Constants.Empty,
        title: this?.title.orEmpty() ?? Constants.Empty,
        imageUrl: this?.imageurl.orEmpty() ?? Constants.Empty);
  }
}

extension StoreMappper on StoreResponse? {
  Store toDomaine() {
    return Store(
        id: this?.id.orZero() ?? Constants.Zero,
        title: this?.title.orEmpty() ?? Constants.Empty,
        imageUrl: this?.imageurl.orEmpty() ?? Constants.Empty);
  }
}

// TODO: Implement this Extension and use it in the mapper li t7t
// extension HomeDataMapper on HomeDataResponse? {
//   HomeData toDomaine() {
//     return HomeData(
//         services: (this
//                     ?.services
//                     ?.map((serviceResponse) => serviceResponse.toDomaine()) ??
//                 const Iterable.empty())
//             .cast<Service>()
//             .toList(),
//         banners: (this
//                     ?.banners
//                     ?.map((bannerResponse) => bannerResponse.toDomaine()) ??
//                 const Iterable.empty())
//             .cast<Banner>()
//             .toList(),
//         stores:
//             (this?.stores?.map((storeResponse) => storeResponse.toDomaine()) ??
//                     const Iterable.empty())
//                 .cast<Store>()
//                 .toList());
//   }
// }

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomaine() {

    // njibo services w banners w stores mn data li 9blha li hiya homedataResponse we nverifiyw ida valid ida valid nb3toha ida nn nb3to [empty] 
    var services = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomaine()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();
    var banners = (this
                ?.data
                ?.banners
                ?.map((bannerResponse) => bannerResponse.toDomaine()) ??
            const Iterable.empty())
        .cast<Banner>()
        .toList();
    var stores = (this
                ?.data
                ?.stores
                ?.map((storeResponse) => storeResponse.toDomaine()) ??
            const Iterable.empty())
        .cast<Store>()
        .toList();
    return HomeObject(homeData: HomeData(
        services: services,
        banners: banners,
        stores: stores
        ));
  }
}


extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomaine(){
    return StoreDetails(
      id: this?.id.orZero() ?? Constants.Zero,
      title: this?.title.orEmpty() ?? Constants.Empty,
     image:this?.image.orEmpty() ?? Constants.Empty,
     details: this?.details.orEmpty() ?? Constants.Empty,
     services: this?.services.orEmpty() ?? Constants.Empty,
     about: this?.about.orEmpty() ?? Constants.Empty,
    );
  }
}