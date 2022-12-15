
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../common/dio/dio.dart';

part 'store_repository.g.dart';

final storeRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return StoreRepository(dio,baseUrl: "https://wlans01.github.io/testdata/data2.json");

});

@RestApi()
abstract class StoreRepository{
  factory StoreRepository(Dio dio, {String baseUrl}) = _StoreRepository;

  @GET('/')
  Future getStoreMarker();
}