import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../const/data.dart';
import '../secure_storage/secure_storage.dart';
import 'dart:developer' as developer;

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(
      storage: storage,
      ref: ref,
    ),
  );

  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  // 1) 신호를 보내기 전에
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    developer.log('[REQ] [${options.method}] ${options.uri}');

    //accessToken 주입
    if (options.headers['authorization'] == 'true') {
      // 헤더 삭제
      options.headers.remove('authorization');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    //refreshToken 주입
    if (options.headers['refreshtoken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('refreshtoken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'refreshtoken': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 403에러가 났을때 (status code)
    // 토큰을 재발급 받는 시도를하고 토큰이 재발급되면
    // 다시 새로운 토큰으로 요청을한다.
    developer
        .log('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // refreshToken 아예 없으면
    // 당연히 에러를 던진다
    if (refreshToken == null) {
      // 에러를 던질때는 handler.reject를 사용한다.
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/refreshTokenRenew';

    if (isStatus401 && !isPathRefresh) {
      developer
          .log('[ERR: access token 만료] [${err.requestOptions.method}] ${err.requestOptions.uri}');
      final dio = Dio();

      try {
        final resp = await dio.put(
          "$BASE_URL/refreshTokenRenew",
          options: Options(
            headers: {
              'authorization': 'Bearer $accessToken',
              'refreshtoken': 'Bearer $refreshToken',
            },
          ),
        );
        final token = resp.headers['authorization']![0];

        final options = err.requestOptions;

        // 토큰 변경하기
        options.headers.addAll({
          'authorization': 'Bearer $token',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: token);

        // 요청 재전송
        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioError catch (e) {
        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
