import 'package:flutter/material.dart';
import 'package:myrt/core/theme/app_theme.dart';
import 'package:myrt/shared/models/news_model.dart';
import 'package:myrt/shared/services/news_services.dart';

class CreateNewsBottomSheet extends StatefulWidget {
  final VoidCallback onNewsCreated;

  const CreateNewsBottomSheet({
    super.key,
    required this.onNewsCreated,
  });

  @override
  State<CreateNewsBottomSheet> createState() => _CreateNewsBottomSheetState();
}

class _CreateNewsBottomSheetState extends State<CreateNewsBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  NewsCategory _selectedCategory = NewsCategory.information;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submitNews() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newNews = News(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        content: _contentController.text,
        author: 'Anda', // Ini nanti diganti dengan user yang login
        authorRole: 'Warga',
        date: DateTime.now(),
        category: _selectedCategory,
      );

      await NewsService.addNews(newNews);
      
      if (mounted) {
        Navigator.pop(context);
        widget.onNewsCreated();
        
        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berita berhasil dipublikasikan'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mempublikasikan berita: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Buat Berita Baru',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            
            // Category Selection
            Text(
              'Kategori',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: NewsCategory.values.map((category) {
                final isSelected = category == _selectedCategory;
                return ChoiceChip(
                  label: Text(category.displayName),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  backgroundColor: Colors.white,
                  selectedColor: category.color.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: isSelected ? category.color : AppTheme.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected ? category.color : Colors.grey.shade300,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            
            // Title Field
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Judul Berita',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Content Field
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Isi Berita',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Isi berita tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitNews,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Text('PUBLIKASIKAN BERITA'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}