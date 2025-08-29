class UserProfile {
  final String id;
  final String documentId;
  final String username;
  final String userAvatar;
  final String jwt;
  final bool isLogin;

  const UserProfile({
    this.id = '',
    this.documentId = '',
    this.username = '',
    this.userAvatar = '',
    this.jwt = '',
    this.isLogin = false,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    final jwt = json['jwt'] ?? '';
    String imageUrl = '';

    if (user['user_avatar'] != null &&
        (user['user_avatar'] as List).isNotEmpty &&
        user['user_avatar'][0]['formats'] != null &&
        user['user_avatar'][0]['formats']['medium'] != null) {
      imageUrl = user['user_avatar'][0]['formats']['medium']['url'];
    }

    return UserProfile(
      id: user['id']?.toString() ?? '',
      documentId: user['documentId'] ?? '',
      username: user['user_name'] ?? '',
      userAvatar: imageUrl, // ✅ 改這裡
      jwt: jwt,
      isLogin: jwt != '',
    );
  }

  UserProfile copyWith({
    String? id,
    String? documentId,
    String? username,
    String? userAvatar,
    String? jwt,
    bool? isLogin,
  }) {
    return UserProfile(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      username: username ?? this.username,
      userAvatar: userAvatar ?? this.userAvatar,
      jwt: jwt ?? this.jwt,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}
