import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'navigation.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation obligatoire de media_kit avant tout usage du lecteur
  // vidéo — enregistre les backends natifs (libmpv) par plateforme.
  MediaKit.ensureInitialized();

  runApp(const ProviderScope(child: IptvPlayerApp()));
}

class IptvPlayerApp extends StatelessWidget {
  const IptvPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lecteur IPTV',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
    );
  }
}
