// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, constant_identifier_names
import 'package:providerlearn/data/Network/app_api.dart';
import 'package:providerlearn/data/Network/error_handler.dart';
import 'package:providerlearn/data/Network/requests.dart';
import 'package:providerlearn/data/Response/responses.dart';

const CacheHomeKey = "Cache_Home_Key";
const CacheHomeInterval = 60 * 1000; // 1 minute Cache in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> SaveHomeToCache(HomeResponse homeresponse);
}

class LocalDataSourceeImpl implements LocalDataSource {
  Map<String, CachedItem> CacheMap = Map();
  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = CacheMap[CacheHomeKey];

    if (cachedItem != null && !cachedItem.isExpired) {
      // return response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
    }
  }

  @override
  Future<void> SaveHomeToCache(homeresponse) async {
    CacheMap[CacheHomeKey] = CachedItem(homeresponse);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool get isExpired =>
      DateTime.now().millisecondsSinceEpoch - cacheTime >= CacheHomeInterval;
}

//TODO: FIX THE NULL Problem
