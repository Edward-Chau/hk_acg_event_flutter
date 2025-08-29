import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/model/User_profile_model.dart';
import 'package:hk_acg_event_information/provider/dio_provider.dart';
import 'package:logger/web.dart';

// 建立 AuthRepository
class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  Future<UserProfile> getMe(String jwt) async {
    try {
      final response = await dio.get('/profile/me');

      return UserProfile.fromJson(response.data);
    } catch (e) {
      throw Exception("未知錯誤: $e");
    }
  }

  Future<UserProfile> register(String email, String password) async {
    try {
      final response = await dio.post(
        '/profile/register',
        data: {
          "email": email,
          "password": password,
        },
      );

      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      // 判斷是否為 400 或 401，代表帳號或密碼錯誤
      if (e.response?.statusCode == 400) {
        throw Exception("註冊資料有誤，請檢查輸入");
      } else if (e.response?.statusCode == 401) {
        throw Exception("未授權，請確認帳號密碼");
      } else {
        throw Exception("伺服器錯誤，請稍後再試");
      }
    } catch (e) {
      throw Exception("未知錯誤: $e");
    }
  }

  /// 登入並回傳 UserProfile
  Future<UserProfile> login(String identifier, String password) async {
    try {
      final response = await dio.post(
        '/profile/login',
        data: {
          "identifier": identifier,
          "password": password,
        },
      );
      Logger().i(response);
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      // 判斷是否為 400 或 401，代表帳號或密碼錯誤
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        throw Exception("帳號或密碼錯誤");
      } else {
        throw Exception("伺服器錯誤，請稍後再試");
      }
    } catch (e) {
      print(e);
      throw Exception("未知錯誤: $e");
    }
  }

  // 登出（清除資料）
  Future<void> logout() async {
    //
  }
}

// Riverpod Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});
