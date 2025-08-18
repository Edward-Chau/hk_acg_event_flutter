class UserProfile {
  final String id;
  final String documentId;
  final String username;
  final String usericon;
  final String jwt;
  final bool isLogin;

  const UserProfile({
    this.id = '',
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

    if (user['user_icon'] != null &&
        (user['user_icon'] as List).isNotEmpty &&
        user['user_icon'][0]['formats'] != null &&
        user['user_icon'][0]['formats']['medium'] != null) {
      imageUrl = user['user_icon'][0]['formats']['medium']['url'];
    }

    return UserProfile(
      id: user['id']?.toString() ?? '',
      documentId: user['documentId'] ?? '',
      username: user['user_name'] ?? '',
      usericon: user['user_icon'] ?? 'http://localhost:1337$imageUrl',
      jwt: jwt,
      isLogin: jwt != '',
    );
  }

  UserProfile copyWith({
    String? id,
    String? documentId,
    String? username,
    String? usericon,
    String? jwt,
    bool? isLogin,
  }) {
    return UserProfile(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      username: username ?? this.username,
      usericon: usericon ?? this.usericon,
      jwt: jwt ?? this.jwt,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}
