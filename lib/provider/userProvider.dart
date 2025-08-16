import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk_acg_event_information/model/User_profile_model.dart';
import 'package:hk_acg_event_information/provider/authRepository.dart';

class UserNotifier extends StateNotifier<UserProfile> {
  final AuthRepository authRepository;

  UserNotifier(this.authRepository) : super(const UserProfile()) {
    _init();
  }

  // 初始化
  Future<void> _init() async {
    print('init');
  }

  /// 登入
  Future<void> login(String identifier, String password) async {
    try {
      final user = await authRepository.login(identifier, password);
      state = user;
    } catch (e) {
      rethrow; // 錯誤往上丟給 UI
    }
  }

  // 登出
  Future<void> logout() async {
    await authRepository.logout();
    state = const UserProfile();
  }
}

// Riverpod StateNotifierProvider
final userProvider = StateNotifierProvider<UserNotifier, UserProfile>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return UserNotifier(repo);
});
