import 'package:flutter/material.dart';

class News {
  final String id;
  final String title;
  final String content;
  final String author;
  final String authorRole;
  final DateTime date;
  final String? imageUrl;
  final int likes;
  final int comments;
  final bool isPinned;
  final NewsCategory category;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.authorRole,
    required this.date,
    this.imageUrl,
    this.likes = 0,
    this.comments = 0,
    this.isPinned = false,
    required this.category,
  });

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) return 'Baru saja';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m yang lalu';
    if (difference.inHours < 24) return '${difference.inHours}j yang lalu';
    if (difference.inDays < 7) return '${difference.inDays}h yang lalu';
    return '${difference.inDays ~/ 7}minggu yang lalu';
  }
}

enum NewsCategory {
  announcement,
  event,
  information,
  emergency,
  social,
}

extension NewsCategoryExtension on NewsCategory {
  String get displayName {
    switch (this) {
      case NewsCategory.announcement:
        return 'Pengumuman';
      case NewsCategory.event:
        return 'Kegiatan';
      case NewsCategory.information:
        return 'Informasi';
      case NewsCategory.emergency:
        return 'Darurat';
      case NewsCategory.social:
        return 'Sosial';
    }
  }

  Color get color {
    switch (this) {
      case NewsCategory.announcement:
        return Colors.blue;
      case NewsCategory.event:
        return Colors.green;
      case NewsCategory.information:
        return Colors.orange;
      case NewsCategory.emergency:
        return Colors.red;
      case NewsCategory.social:
        return Colors.purple;
    }
  }

  IconData get icon {
    switch (this) {
      case NewsCategory.announcement:
        return Icons.announcement;
      case NewsCategory.event:
        return Icons.event;
      case NewsCategory.information:
        return Icons.info;
      case NewsCategory.emergency:
        return Icons.warning;
      case NewsCategory.social:
        return Icons.people;
    }
  }
}