import 'package:flutter/material.dart';

class PostModel {
  final String id;
  final String authorName;
  final String authorRole;
  final String avatarUrl;
  final String content;
  final DateTime createdAt;
  final int likes;
  final int comments;
  final Color accentColor;
  final String? imageUrl;

  const PostModel({
    required this.id,
    required this.authorName,
    required this.authorRole,
    required this.avatarUrl,
    required this.content,
    required this.createdAt,
    this.likes = 0,
    this.comments = 0,
    this.accentColor = const Color(0xFF5E7CE2),
    this.imageUrl,
  });

  PostModel copyWith({
    String? id,
    String? authorName,
    String? authorRole,
    String? avatarUrl,
    String? content,
    DateTime? createdAt,
    int? likes,
    int? comments,
    Color? accentColor,
    String? imageUrl,
  }) {
    return PostModel(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorRole: authorRole ?? this.authorRole,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      accentColor: accentColor ?? this.accentColor,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
