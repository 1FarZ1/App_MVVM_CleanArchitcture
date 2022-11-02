// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, constant_identifier_names
import 'package:providerlearn/data/Network/app_api.dart';
import 'package:providerlearn/data/Network/error_handler.dart';
import 'package:providerlearn/data/Network/requests.dart';
import 'package:providerlearn/data/Response/responses.dart';

// the key of our cached data
const CacheHomeKey = "Cache_Home_Key";
const CacheHomeInterval = 60 * 1000; // 1 minute Cache in millis
const CacheStoreDetailsKey = "Cache_Store_Key";
const CacheStoreDetailsInterval = 60 * 1000; // 1 minute Cache in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> SaveHomeToCache(HomeResponse homeresponse);
  void clearCache();
  void removeFromCache(String key);

  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> SaveStoreDetailsToCache(
      StoreDetailsResponse storeDetailsResponse);
}

class LocalDataSourceeImpl implements LocalDataSource {

  Map<String, CachedItem> CacheMap = {};



  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = CacheMap[CacheHomeKey];

    if (cachedItem != null && !cachedItem.isExpired) {
      // return response from cache
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
      // return an error that cache is not there or its not valid
    }
  }

  @override
  Future<void> SaveHomeToCache(homeresponse) async {
    // for exemple here:
    // {
    //  "key here": {
    //      "data": homeresponse,
    //      "time": DateTime.now().millisecondsSinceEpoch
    // }  ,
    //  another one here is :
    // "another_key": {
    //  "data":storedData,
    //  "time": DateTime.now().millisecondsSinceEpoch
    // }
    // }
    CacheMap[CacheHomeKey] = CachedItem(homeresponse);
  }

  @override
  void clearCache() {
    // remove all items from cache
    CacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    // remove a particular item from cache
    CacheMap.remove(key);
  }

  @override
  Future<void> SaveStoreDetailsToCache(
      StoreDetailsResponse storeDetailsResponse) async {
    CacheMap[CacheStoreDetailsKey] = CachedItem(storeDetailsResponse);
    
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() {
    CachedItem? cachedItem = CacheMap[CacheStoreDetailsKey];

    if (cachedItem != null && !cachedItem.isExpired) {
      // return response from cache
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
      // return an error that cache is not there or its not valid
    }
  }
}

class CachedItem {
  // the data that we want it locally
  dynamic data;

  // when we added the cached item
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool get isExpired =>
      DateTime.now().millisecondsSinceEpoch - cacheTime >= CacheHomeInterval;
}

//TODO: FIX THE NULL Problem
