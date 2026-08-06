/// Design system de l'application — couleurs, typographie, métriques,
/// et ThemeData Material assemblés dans un seul fichier.
///
/// Principe directeur du fond : il doit rester quasi-inerte pour que les
/// posters et thumbnails (contenu variable, hors de notre contrôle)
/// restent la seule source de couleur vive à l'écran. Un seul accent,
/// jamais de dégradés multicolores.
library;

import 'package:flutter/material.dart';

// ============================================================
// COULEURS
// ============================================================

abstract final class AppColors {
  // Fonds — noir quasi-pur, jamais de gris moyen qui platit le contraste
  // des posters au repos.
  static const Color background = Color(0xFF0A0A0C);
  static const Color surface = Color(0xFF141416);
  static const Color surfaceElevated = Color(0xFF1C1C1F);
  static const Color surfaceOverlay = Color(0xE60A0A0C); // scrims / modals

  // Accent unique — réservé aux états actifs, CTA, progression.
  // Ne jamais l'utiliser pour de la simple décoration.
  static const Color accent = Color(0xFFFF6B35);
  static const Color accentMuted = Color(0x33FF6B35); // halos, focus rings

  // Texte — blanc cassé, jamais blanc pur (fatigue visuelle en usage
  // prolongé, typique d'un lecteur média utilisé le soir).
  static const Color textPrimary = Color(0xFFF2F0ED);
  static const Color textSecondary = Color(0xFFA8A6A2);
  static const Color textTertiary = Color(0xFF6B6966);

  // États sémantiques — désaturés, pour ne pas concurrencer l'accent.
  static const Color success = Color(0xFF4CAF7D);
  static const Color error = Color(0xFFE05252);
  static const Color warning = Color(0xFFD9A441);

  // Structure
  static const Color divider = Color(0xFF232326);
  static const Color scrimGradientStart = Color(0x00000000);
  static const Color scrimGradientEnd = Color(0xE60A0A0C);
}

// ============================================================
// TYPOGRAPHIE
// ============================================================

/// Deux registres volontairement distincts :
/// - Une display condensée à forte personnalité pour les titres (accroche,
///   noms de films/séries) — donne le ton "premium", pas générique.
/// - Une neutre haute lisibilité pour le corps et les métadonnées, où la
///   personnalité doit s'effacer devant la clarté (genres, durées, EPG).
///
/// NB : GeneralSans / Inter ne sont pas des polices système. Deux options :
///   1. Ajouter les .ttf dans assets/fonts/ et les déclarer dans pubspec.yaml
///   2. Remplacer _display / _body par null pour utiliser la police système
///      par défaut en attendant (SF Pro / Roboto).
abstract final class AppTypography {
  static const String _display = 'GeneralSans';
  static const String _body = 'Inter';

  static const TextStyle displayLarge = TextStyle(
    fontFamily: _display,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _display,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    height: 1.15,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleCard = TextStyle(
    fontFamily: _display,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: _body,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  static const TextStyle meta = TextStyle(
    fontFamily: _body,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 1.3,
    color: AppColors.textTertiary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: _body,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle chip = TextStyle(
    fontFamily: _body,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}

// ============================================================
// MÉTRIQUES — rayons, espacements, durées, courbes
// ============================================================

/// Rayons volontairement modérés (8px) — pas 20px façon iOS générique,
/// qui accentue l'effet "app template".
abstract final class AppRadius {
  static const double card = 8.0;
  static const double chip = 20.0; // pilule pour les filtres, seul endroit arrondi
  static const double sheet = 16.0; // bottom sheets, modals
  static const double button = 10.0;
}

abstract final class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double screenPadding = 20.0;
}

abstract final class AppDurations {
  static const Duration cardFocus = Duration(milliseconds: 180);
  static const Duration pageTransition = Duration(milliseconds: 280);
  static const Duration controlsFade = Duration(milliseconds: 220);
  static const Duration skeletonShimmer = Duration(milliseconds: 1200);
}

abstract final class AppCurves {
  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeOutQuart;
}

/// Échelle de focus pour les cartes (poster/chaîne) — scale discret,
/// pas de bordure colorée cliché.
abstract final class AppFocus {
  static const double cardScale = 1.03;
  static const double elevationBlur = 24.0;
  static const double elevationOpacity = 0.35;
}

// ============================================================
// THEMEDATA
// ============================================================

/// Thème global — un seul thème (sombre), un lecteur média premium n'a
/// pas vocation à proposer un mode clair.
abstract final class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.background,
        primary: AppColors.accent,
        secondary: AppColors.accent,
        error: AppColors.error,
      ),

      textTheme: base.textTheme.copyWith(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        titleMedium: AppTypography.titleCard,
        bodyMedium: AppTypography.body,
        labelSmall: AppTypography.meta,
        labelLarge: AppTypography.button,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.displayMedium,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.accentMuted,
        elevation: 0,
        height: 64,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return AppTypography.meta.copyWith(
            color: selected ? AppColors.accent : AppColors.textTertiary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? AppColors.accent : AppColors.textTertiary,
            size: 24,
          );
        }),
      ),

      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.surfaceElevated,
        selectedColor: AppColors.accent,
        labelStyle: AppTypography.chip,
        secondaryLabelStyle:
            AppTypography.chip.copyWith(color: AppColors.background),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
        side: BorderSide.none,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.background,
          textStyle: AppTypography.button,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          elevation: 0,
        ),
      ),

      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 22),

      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
    );
  }
}
