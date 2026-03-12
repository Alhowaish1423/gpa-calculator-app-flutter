import 'package:flutter/material.dart';
import 'package:mygpa_app/phase0/my_gpa.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 122, 180, 173),
);

void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.primary,
        foregroundColor: kColorScheme.onPrimary,
      ),
      cardTheme: const CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.secondaryContainer,
          foregroundColor: kColorScheme.onSecondaryContainer,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      dialogTheme: ThemeData().dialogTheme.copyWith(
            backgroundColor: kColorScheme.surfaceContainerHighest,
            titleTextStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: kColorScheme.error,
            ),
            contentTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: kColorScheme.onSurfaceVariant,
            ),
          ),
    ),
    home: const SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheAssets();
    });
  }

  Future<void> _precacheAssets() async {
    List<String> imagePaths = [

      'images/786af4a4a3756b9dacab344f6fffac11.png',
      'images/3842b946cdd8c7db1e5aac21ea3655b5.png',
      'images/258000afc3b4703d8d0079467949343b.png',
      'images/b1dcf849502577c4aca7c026c1a7d087.png',
      'images/d38c5a15d856ec2a5d6a41330f327b17.png',
      'images/fail1.png',
      'images/fb50d010ef7944aa9577fe5844eb9a1b.png',
      'images/gpaImage.png',
      'images/linkedin.png'

      // Add more images as needed
    ];

    for (var path in imagePaths) {
      await precacheImage(AssetImage(path), context);
    }

    // Navigate to the main app screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MyGpa()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              "Loading assets...",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
