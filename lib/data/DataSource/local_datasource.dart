// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:providerlearn/data/Network/app_api.dart';
import 'package:providerlearn/data/Network/requests.dart';
import 'package:providerlearn/data/Response/responses.dart';

const CacheHomeKey = "Cache_Home_Key";

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> SaveHomeToCache(HomeResponse homeresponse);
}

class LocalDataSourceeImpl implements LocalDataSource {
  Map<String, CachedItem> CacheMap = Map();
  @override
  Future<HomeResponse> getHome() async {
    throw UnimplementedError;
  }
  
  @override
  Future<void> SaveHomeToCache(homeresponse) async {

  CacheMap[CacheHomeKey]=CachedItem(homeresponse);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

//TODO: FIX THE NULL Problem
