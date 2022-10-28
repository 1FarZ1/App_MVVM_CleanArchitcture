// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, non_constant_identifier_names

// OnBoarding Models

class SliderObject {
  String HeadLine;
  String Subline;
  String image;

  SliderObject(this.HeadLine, this.Subline, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

// Login Models
class Customer {
  String id;
  String name;
  int numberofNotifications;
  Customer({
    required this.id,
    required this.name,
    required this.numberofNotifications,
  });
}

class Contacts {
  String phone;
  String email;
  String link;
  Contacts({
    required this.phone,
    required this.email,
    required this.link,
  });
}

class Auth {
  Customer? customer;
  Contacts? contacts;

  Auth({
    required this.customer,
    required this.contacts,
  });
}

class RegisterO {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  RegisterO({
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}

class Service {
  String id;
  String title;
  String imageUrl;
  Service({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}

class Store {
  String id;
  String title;
  String imageUrl;
  Store({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}

class Banner {
  String id;
  String title;
  String imageUrl;
  String link;
  Banner({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.link,
  });
}

class HomeData {
  List<Service> services;
  List<Service> banners;
  List<Service> stores;
  HomeData({
    required this.services,
    required this.banners,
    required this.stores,
  });
}

class HomeObject {
  HomeData? homeData;
  
  HomeObject(this.homeData);
}
