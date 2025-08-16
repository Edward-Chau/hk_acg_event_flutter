class UserProfile {
  final String documentId;
  final String username;
  final String usericon;
  final String jwt;
  final bool isLogin;

  const UserProfile({
    this.documentId = '',
    this.username = '',
    this.usericon = '',
    this.jwt = '',
    this.isLogin = false,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    final jwt = json['jwt'] ?? '';
    String imageUrl = '';

    // 取 user_icon 第一張的 medium url，如果有的話
    if (user['user_icon'] != null &&
        (user['user_icon'] as List).isNotEmpty &&
        user['user_icon'][0]['formats'] != null &&
        user['user_icon'][0]['formats']['medium'] != null) {
      imageUrl = user['user_icon'][0]['formats']['medium']['url'];
    }

    return UserProfile(
      documentId: user['documentId'] ?? '',
      username: user['user_name'] ?? '',
      usericon: 'http://localhost:1337$imageUrl',
      jwt: jwt,
      isLogin: jwt != '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'username': username,
      'image': usericon,
      'jwt': jwt,
      'isLogin': isLogin,
    };
  }
}
