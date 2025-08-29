import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hk_acg_event_information/model/User_profile_model.dart';
import 'package:hk_acg_event_information/provider/authRepository.dart';
import 'package:logger/web.dart';

class UserNotifier extends StateNotifier<UserProfile> {
  final AuthRepository authRepository;

  UserNotifier(this.authRepository) : super(const UserProfile()) {
    _init();
  }

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // 初始化
  Future<void> _init() async {
    Logger().i('init user state...');
    final jwt = await _secureStorage.read(key: 'jwt');
    if (jwt != null && jwt.isNotEmpty) {
      try {
        final user = await authRepository.getMe(jwt);
        state = user.copyWith(jwt: jwt, isLogin: true); // 手動把 jwt 存回 state
        Logger().i("自動登入成功");
      } catch (e) {
        Logger().e("自動登入失敗: $e");
        await _secureStorage.delete(key: 'jwt');
      }
    } else {
      Logger().i('沒有 jwt token');
    }
  }

  // 取得目前 jwt (如果需要 API call 時使用)
  Future<String?> getJwt() async {
    return await _secureStorage.read(key: 'jwt');
  }

  /// 註冊
  Future<void> register(String email, String password) async {
    try {
      final user = await authRepository.register(email, password);
      //save jwt token
      await _secureStorage.write(key: 'jwt', value: user.jwt);
      state = user;
      Logger().d('成功登入');
    } catch (e) {
      rethrow; // 錯誤往上丟給 UI
    }
  }

  /// 登入
  Future<void> login(String identifier, String password) async {
    try {
      final user = await authRepository.login(identifier, password);
      //save jwt token
      await _secureStorage.write(key: 'jwt', value: user.jwt);
      state = user;
      Logger().d('成功登入');
    } catch (e) {
      rethrow; // 錯誤往上丟給 UI
    }
  }

  // 登出
  Future<void> logout() async {
    await _secureStorage.delete(key: 'jwt');
    await authRepository.logout();
    state = const UserProfile();
    Logger().d('成功登出');
  }

  // update profile
  Future<void> update({
    required String? userName,
    required String? userAvatar,
  }) async {
    try {
      final Dio dio = authRepository.dio;

      String? newAvatarUrl;

      // 1. 如果有 file，要先上傳圖片到 Strapi
      if (userAvatar != null) {
        final formData = FormData.fromMap({
          "files": await MultipartFile.fromFile(
            userAvatar,
            filename: userAvatar.split('/').last,
          ),
        });

        final uploadRes = await dio.post("/upload", data: formData);

        if (uploadRes.statusCode == 200) {
          final uploadedFile = uploadRes.data[0];
          newAvatarUrl = uploadedFile["url"];
          Logger().d("✅ 圖片上傳成功: $newAvatarUrl");
        } else {
          throw Exception("圖片上傳失敗: ${uploadRes.statusCode}");
        }
      }

      final result = await dio.put(
        '/profile/update',
        data: {
          if (userName != null) "user_name": userName,
          if (newAvatarUrl != null) "user_avatar": newAvatarUrl,
        },
      );

      if (result.statusCode != 200) {
        throw Exception("更新失敗，請稍後再試");
      }

      state = state.copyWith(
        username: userName ?? state.username,
        userAvatar: newAvatarUrl ?? state.userAvatar,
      );
      Logger().d('✅ Profile 更新成功');
    } catch (e) {
      rethrow; // 錯誤往上丟給 UI
    }
  }
}

// Riverpod StateNotifierProvider
final userProvider = StateNotifierProvider<UserNotifier, UserProfile>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return UserNotifier(repo);
});
