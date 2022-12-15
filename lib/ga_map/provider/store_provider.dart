import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/store_model.dart';
import '../repository/store_repository.dart';

final storeProvider =
    StateNotifierProvider<StoreProvider, List<StoreModel>>((ref) {
  final storeRepository = ref.watch(storeRepositoryProvider);
  return StoreProvider(storeRepository: storeRepository);
});

class StoreProvider extends StateNotifier<List<StoreModel>> {
  final StoreRepository storeRepository;
  late Uint8List markerIcon;

  StoreProvider({
    required this.storeRepository,
  }) : super([]) {
    getStore();
  }

  Future<List<StoreModel>> getStore() async {
    // final res = await storeRepository.getStoreMarker();
    final res = markerData.map((e) => StoreModel.fromJson(e)).toList();
    state = res;
    return res;
  }
}

const markerData = [
  {
    "id": "j-0",
    "latitude": 36.633717781404734,
    "longitude": 127.45759570354707,
    "title": "왕큰손파닭",
    "snippet": "파닭,치킨"
  },
  {
    "id": "j-1",
    "latitude": 36.63393529385305,
    "longitude": 127.45913005635082,
    "title": "왕천파닭",
    "snippet": "파닭,치킨"
  },
  {
    "id": "j-2",
    "latitude": 36.63302293024008,
    "longitude": 127.45946080219105,
    "title": "아웃닭",
    "snippet": "순살닭"
  },
  {
    "id": "j-3",
    "latitude": 36.632572256553544,
    "longitude": 127.45880952750781,
    "title": "부리또인",
    "snippet": "부리또"
  },
  {
    "id": "j-4",
    "latitude": 36.6340694556524,
    "longitude": 127.456114295327,
    "title": "바니쉬버거",
    "snippet": "수제버거"
  }
];
