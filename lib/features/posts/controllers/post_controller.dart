import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';

class PostController extends GetxController {
  final RxList<PostModel> posts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    posts.addAll([
      PostModel(
        id: '1',
        authorName: 'Sarah Ahmed',
        authorRole: 'Product Designer · Meta',
        avatarUrl: 'https://i.pravatar.cc/150?img=11',
        content:
            '''Excited to share that I have accepted a new offer as a Senior Product Designer at Meta!
Working with cross-functional teams to build inclusive experiences has been a dream come true.''',
        createdAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 15)),
        likes: 187,
        comments: 42,
        accentColor: const Color(0xFF5E7CE2),
      ),
      PostModel(
        id: '2',
        authorName: 'Luis Romero',
        authorRole: 'Flutter Engineer · Spotify',
        avatarUrl: 'https://i.pravatar.cc/150?img=32',
        content:
            'Here are a few takeaways from our latest Flutter performance deep dive. The key is profiling early and continuously collaborating with design.',
        createdAt: DateTime.now().subtract(const Duration(hours: 5, minutes: 40)),
        likes: 96,
        comments: 18,
        accentColor: const Color(0xFF4DB8AC),
      ),
      PostModel(
        id: '3',
        authorName: 'India Tech Summit',
        authorRole: 'Community Event',
        avatarUrl: 'https://i.pravatar.cc/150?img=55',
        content:
            'Moments from today’s design systems panel. Loved hearing how teams across APAC are scaling inclusive UI libraries.',
        createdAt: DateTime.now().subtract(const Duration(hours: 9, minutes: 5)),
        likes: 312,
        comments: 58,
        accentColor: const Color(0xFF9B59B6),
        imageUrl:
            'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=1200&q=80',
      ),
    ]);
  }

  void addPost(String content, {String? imageUrl}) {
    if (content.trim().isEmpty && (imageUrl == null || imageUrl.isEmpty)) {
      return;
    }

    final newPost = PostModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorName: 'You',
      authorRole: 'Community Member',
      avatarUrl: 'https://i.pravatar.cc/150?img=65',
      content: content.trim(),
      createdAt: DateTime.now(),
      accentColor: const Color(0xFFFF8A65),
      imageUrl: imageUrl?.isNotEmpty == true ? imageUrl : null,
    );

    posts.insert(0, newPost);
  }
}
