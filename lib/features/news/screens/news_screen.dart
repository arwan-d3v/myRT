import 'package:flutter/material.dart';
import 'package:myrt/core/theme/app_theme.dart';
import 'package:myrt/shared/models/news_model.dart';
import 'package:myrt/shared/services/news_services.dart';
import 'package:myrt/features/news/widgets/news_card.dart';
import 'package:myrt/features/news/widgets/create_news_bottom_sheet.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<News>> _newsFuture;
  final List<NewsCategory> _categories = NewsCategory.values;

  @override
  void initState() {
    super.initState();
    _newsFuture = NewsService.getNews();
  }

  void _refreshNews() {
    setState(() {
      _newsFuture = NewsService.getNews();
    });
  }

  void _showCreateNewsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateNewsBottomSheet(
        onNewsCreated: _refreshNews,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateNewsSheet,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    'Berita & Informasi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _refreshNews,
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.refresh, color: AppTheme.textSecondary, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            // Category Chips
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: false,
                      onSelected: (_) {},
                      label: Text(category.displayName),
                      backgroundColor: Colors.white,
                      selectedColor: category.color.withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      checkmarkColor: category.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // News List
            Expanded(
              child: FutureBuilder<List<News>>(
                future: _newsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, color: Colors.red, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            'Gagal memuat berita',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final newsList = snapshot.data!;

                  if (newsList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Icon(
                              Icons.newspaper,
                              size: 40,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Belum ada berita',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Jadilah yang pertama membagikan informasi',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      _refreshNews();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: newsList.length,
                      itemBuilder: (context, index) {
                        final news = newsList[index];
                        return NewsCard(
                          news: news,
                          onLike: () => _likeNews(news.id),
                          onComment: () => _commentOnNews(news.id),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _likeNews(String newsId) async {
    await NewsService.likeNews(newsId);
    _refreshNews();
  }

  void _commentOnNews(String newsId) async {
    await NewsService.addComment(newsId);
    _refreshNews();
    // TODO: Navigate to comments page
  }
}