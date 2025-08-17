// dio_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:1337/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  // 加入攔截器，自動附加 jwt
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      const storage = FlutterSecureStorage();
      final jwt = await storage.read(key: 'jwt');
      if (jwt != null && jwt.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $jwt';
      }
      return handler.next(options);
    },
  ));

  return dio;
});
