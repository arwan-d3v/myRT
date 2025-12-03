import 'package:myrt/shared/models/news_model.dart';

class NewsService {
  // Mock data - nanti bisa diganti dengan API real
  static final List<News> _mockNews = [
    News(
      id: '1',
      title: 'Kerja Bakti Lingkungan RT 05',
      content: 'Mari kita bersama-sama membersihkan lingkungan RT 05 pada hari Sabtu depan. Bawa peralatan kebersihan masing-masing. Target kita membersihkan selokan dan taman umum.',
      author: 'Budi Santoso',
      authorRole: 'Ketua RT',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      imageUrl: null,
      likes: 24,
      comments: 8,
      isPinned: true,
      category: NewsCategory.event,
    ),
    News(
      id: '2',
      title: 'Pengumuman Bantuan Sosial',
      content: 'Pemerintah akan memberikan bantuan sosial untuk warga yang memenuhi kriteria. Silakan daftar di sekretariat RT dengan membawa KTP dan KK.',
      author: 'Siti Rahayu',
      authorRole: 'Sekretaris RT',
      date: DateTime.now().subtract(const Duration(days: 1)),
      imageUrl: null,
      likes: 45,
      comments: 12,
      isPinned: false,
      category: NewsCategory.announcement,
    ),
    News(
      id: '3',
      title: 'Perbaikan Jalan Gang Melati',
      content: 'Mulai besok akan dilakukan perbaikan jalan di Gang Melati. Mohon warga menghindari area tersebut selama pengerjaan.',
      author: 'Ahmad Fauzi',
      authorRole: 'Bendahara RT',
      date: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: null,
      likes: 18,
      comments: 5,
      isPinned: false,
      category: NewsCategory.information,
    ),
    News(
      id: '4',
      title: 'Posyandu Bulan Ini',
      content: 'Posyandu untuk balita dan lansia akan dilaksanakan pada tanggal 15 di balai RT. Bawa buku KIA/KMS untuk balita.',
      author: 'Dewi Kurnia',
      authorRole: 'Kader Posyandu',
      date: DateTime.now().subtract(const Duration(days: 3)),
      imageUrl: null,
      likes: 32,
      comments: 7,
      isPinned: false,
      category: NewsCategory.social,
    ),
    News(
      id: '5',
      title: 'Pemadaman Listrik Bergilir',
      content: 'Akan ada pemadaman listrik bergilir besok dari jam 08.00-16.00. Mohon persiapkan kebutuhan warga.',
      author: 'Budi Santoso',
      authorRole: 'Ketua RT',
      date: DateTime.now().subtract(const Duration(days: 4)),
      imageUrl: null,
      likes: 29,
      comments: 15,
      isPinned: false,
      category: NewsCategory.emergency,
    ),
  ];

  static Future<List<News>> getNews() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Sort by pinned first, then by date (newest first)
    _mockNews.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.date.compareTo(a.date);
    });
    
    return _mockNews;
  }

  static Future<void> addNews(News news) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mockNews.insert(0, news);
  }

  static Future<void> likeNews(String newsId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final news = _mockNews.firstWhere((news) => news.id == newsId);
    final index = _mockNews.indexOf(news);
    _mockNews[index] = news.copyWith(likes: news.likes + 1);
  }

  static Future<void> addComment(String newsId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final news = _mockNews.firstWhere((news) => news.id == newsId);
    final index = _mockNews.indexOf(news);
    _mockNews[index] = news.copyWith(comments: news.comments + 1);
  }
}

// Extension untuk copyWith method
extension NewsCopyWith on News {
  News copyWith({
    String? id,
    String? title,
    String? content,
    String? author,
    String? authorRole,
    DateTime? date,
    String? imageUrl,
    int? likes,
    int? comments,
    bool? isPinned,
    NewsCategory? category,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      authorRole: authorRole ?? this.authorRole,
      date: date ?? this.date,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isPinned: isPinned ?? this.isPinned,
      category: category ?? this.category,
    );
  }
}