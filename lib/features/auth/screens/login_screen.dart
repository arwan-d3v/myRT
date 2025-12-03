import 'package:flutter/material.dart';
import 'package:myrt/core/theme/app_theme.dart';
import 'package:myrt/features/home/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              
              // Logo dan Judul
              _buildHeader(),
              const SizedBox(height: 48),
              
              // Form Login
              _buildLoginForm(context),
              const SizedBox(height: 24),
              
              // Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.people_alt, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 24),
        Text(
          'MyRT Digital',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Dashboard Digital RT Modern',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Masuk ke Akun',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Silakan masuk dengan akun Anda',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            
            // Email Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Email atau NIK',
                prefixIcon: Icon(Icons.person_outline, color: AppTheme.textSecondary),
              ),
            ),
            const SizedBox(height: 16),
            
            // Password Field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline, color: AppTheme.textSecondary),
              ),
            ),
            const SizedBox(height: 16),
            
            // Remember Me & Forgot Password
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                Text(
                  'Ingat saya',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lupa Password?',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Home
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('MASUK'),
              ),
            ),
            const SizedBox(height: 16),
            
            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: AppTheme.textSecondary.withOpacity(0.3))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'atau',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: AppTheme.textSecondary.withOpacity(0.3))),
              ],
            ),
            const SizedBox(height: 16),
            
            // Register Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(color: AppTheme.primaryColor),
                ),
                child: Text(
                  'DAFTAR AKUN BARU',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          'Dukung Digitalisasi Lingkungan Kita',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Versi 1.0.0',
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}