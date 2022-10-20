import 'package:providerlearn/data/Response/responses.dart';
import 'package:providerlearn/domaine/models/Models.dart';
import "package:providerlearn/app/extensions.dart";

import '../../app/consts.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomaine() {
    return Customer(
        id: this?.id.orEmpty() ?? Constants.Empty,
        name: this?.name.orEmpty() ?? Constants.Empty,
        numberofNotifications: this?.numberofNotifications.orZero() ?? Constants.Zero);
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
        contacts: this?.contact.toDomaine()
    );
  }
}



