import 'package:hk_acg_event_information/model/User_profile_model.dart';

class Thread {
  final UserProfile author;
  final String threadTitle;
  final List<String> threadTags;
  final String threadContent;

  Thread({
    required this.author,
    this.threadTitle = '',
    this.threadTags = const [],
    this.threadContent = '',
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      author: UserProfile.fromJson(json['author'] ?? {}),
      threadTitle: json['threadTitle'] ?? '',
      threadTags: (json['threadTags'] as List<dynamic>? ?? []).cast<String>(),
      threadContent: json['threadContent'] ?? '',
    );
  }
}
