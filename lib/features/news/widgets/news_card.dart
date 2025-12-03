import 'package:flutter/material.dart';
import 'package:myrt/core/theme/app_theme.dart';
import 'package:myrt/shared/models/news_model.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const NewsCard({
    super.key,
    required this.news,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan kategori dan pin
            Row(
              children: [
                // Category Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: news.category.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: news.category.color.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        news.category.icon,
                        size: 12,
                        color: news.category.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        news.category.displayName,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: news.category.color,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Pin indicator
                if (news.isPinned)
                  Icon(Icons.push_pin, color: Colors.amber, size: 16),
              ],
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              news.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            // Content
            Text(
              news.content,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 16),

            // Author and time
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 16,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.author,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        '${news.authorRole} • ${news.timeAgo}',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Actions
            Row(
              children: [
                // Like button
                _buildActionButton(
                  icon: Icons.thumb_up_outlined,
                  activeIcon: Icons.thumb_up,
                  count: news.likes,
                  onPressed: onLike,
                ),
                const SizedBox(width: 16),
                // Comment button
                _buildActionButton(
                  icon: Icons.comment_outlined,
                  activeIcon: Icons.comment,
                  count: news.comments,
                  onPressed: onComment,
                ),
                const Spacer(),
                // Share button
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share, size: 18, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required IconData activeIcon,
    required int count,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.textSecondary),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}