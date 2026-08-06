/// Composants réutilisables du design system : carte poster, tuile de
/// chaîne, rail horizontal de contenu, carte hero de reprise de lecture.
library;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

// ============================================================
// MEDIA POSTER CARD — films et séries, ratio 2:3
// ============================================================

/// Carte poster pour un film ou une série — ratio 2:3 strict.
///
/// L'effet de focus (tap-hold / navigation télécommande) est un scale
/// discret + ombre portée, jamais une bordure colorée : c'est ce détail
/// qui distingue un design "pensé" d'un template par défaut.
class MediaPosterCard extends StatefulWidget {
  const MediaPosterCard({
    super.key,
    required this.title,
    required this.posterUrl,
    this.progress, // 0.0–1.0, null si jamais commencé
    this.onTap,
    this.width, // null => s'adapte à la largeur disponible (usage en GridView)
  });

  final String title;
  final String? posterUrl;
  final double? progress;
  final VoidCallback? onTap;
  final double? width;

  @override
  State<MediaPosterCard> createState() => _MediaPosterCardState();
}

class _MediaPosterCardState extends State<MediaPosterCard> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final fixedWidth = widget.width;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _focused = true),
      onTapCancel: () => setState(() => _focused = false),
      onTapUp: (_) => setState(() => _focused = false),
      child: AnimatedScale(
        scale: _focused ? AppFocus.cardScale : 1.0,
        duration: AppDurations.cardFocus,
        curve: AppCurves.standard,
        child: SizedBox(
          width: fixedWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: AppDurations.cardFocus,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  boxShadow: _focused
                      ? [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(AppFocus.elevationOpacity),
                            blurRadius: AppFocus.elevationBlur,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : [],
                ),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _poster(),
                        if (widget.progress != null && widget.progress! > 0)
                          _progressOverlay(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                widget.title,
                style: AppTypography.titleCard,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _poster() {
    if (widget.posterUrl == null) {
      return const Center(
        child: Icon(Icons.movie_outlined,
            color: AppColors.textTertiary, size: 32),
      );
    }
    return CachedNetworkImage(
      imageUrl: widget.posterUrl!,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          Container(color: AppColors.surfaceElevated),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.broken_image_outlined,
            color: AppColors.textTertiary, size: 28),
      ),
    );
  }

  Widget _progressOverlay() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 3,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white.withOpacity(0.25),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: widget.progress!.clamp(0.0, 1.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: AppColors.accent,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CHANNEL TILE — chaînes TV en direct, format carré
// ============================================================

/// Tuile de chaîne TV en direct.
///
/// Les logos de chaînes IPTV sont d'une hétérogénéité totale — formats,
/// fonds transparents ou blancs, résolutions variables. Le seul moyen
/// d'obtenir une grille cohérente est d'imposer un fond neutre uniforme
/// et de contraindre le logo en BoxFit.contain avec padding généreux.
class ChannelTile extends StatelessWidget {
  const ChannelTile({
    super.key,
    required this.name,
    required this.logoUrl,
    this.isLive = false,
    this.onTap,
  });

  final String name;
  final String? logoUrl;
  final bool isLive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Center(child: _logo()),
                  ),
                  if (isLive)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            name,
            style: AppTypography.meta.copyWith(color: AppColors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _logo() {
    if (logoUrl == null) {
      return const Icon(Icons.live_tv_outlined,
          color: AppColors.textTertiary, size: 28);
    }
    return CachedNetworkImage(
      imageUrl: logoUrl!,
      fit: BoxFit.contain,
      errorWidget: (context, url, error) => const Icon(
        Icons.live_tv_outlined,
        color: AppColors.textTertiary,
        size: 28,
      ),
    );
  }
}

// ============================================================
// CONTENT RAIL — rail horizontal générique
// ============================================================

/// Rail horizontal de contenu — brique de base de l'écran d'accueil et
/// des grilles par catégorie.
class ContentRail extends StatelessWidget {
  const ContentRail({
    super.key,
    required this.title,
    required this.itemBuilder,
    required this.itemCount,
    this.onSeeAll,
    this.itemSpacing = AppSpacing.sm,
    this.height = 230,
  });

  final String title;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final VoidCallback? onSeeAll;
  final double itemSpacing;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTypography.displayMedium),
              if (onSeeAll != null)
                GestureDetector(
                  onTap: onSeeAll,
                  child: Text(
                    'Tout voir',
                    style: AppTypography.meta.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            itemCount: itemCount,
            separatorBuilder: (_, __) => SizedBox(width: itemSpacing),
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// RESUME HERO CARD — bandeau de reprise de lecture
// ============================================================

/// Carte hero "Reprendre" — bandeau horizontal en tête de l'accueil.
///
/// C'est le geste le plus répété par l'utilisateur d'un lecteur média ;
/// il mérite une position centrale. Poster en fond, scrim dégradé pour
/// la lisibilité du texte, barre de progression fine en bas.
class ResumeHeroCard extends StatelessWidget {
  const ResumeHeroCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backdropUrl,
    required this.progress,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String? backdropUrl;
  final double progress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (backdropUrl != null)
                  CachedNetworkImage(imageUrl: backdropUrl!, fit: BoxFit.cover)
                else
                  Container(color: AppColors.surfaceElevated),

                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.scrimGradientStart,
                        AppColors.scrimGradientEnd,
                      ],
                      stops: [0.35, 1.0],
                    ),
                  ),
                ),

                Positioned(
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  bottom: AppSpacing.md,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: AppColors.background,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  title,
                                  style: AppTypography.displayMedium
                                      .copyWith(fontSize: 18),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  subtitle,
                                  style: AppTypography.meta,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          minHeight: 3,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation(
                            AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
