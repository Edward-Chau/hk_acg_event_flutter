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
}

// Riverpod StateNotifierProvider
final userProvider = StateNotifierProvider<UserNotifier, UserProfile>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return UserNotifier(repo);
});
