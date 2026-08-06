import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'theme.dart';
import 'widgets.dart';

/// Écran d'accueil.
///
/// Structure : hero de reprise en tête, puis rails horizontaux
/// (Favoris, catégories détectées dans la source active). Pas de menu
/// hamburger — la navigation principale vit dans la bottom bar.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
                vertical: AppSpacing.md,
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Accueil', style: AppTypography.displayLarge),
                    GestureDetector(
                      onTap: () => context.push('/profile'),
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.surfaceElevated,
                        child: Icon(
                          Icons.person_outline,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: ResumeHeroCard(
                title: 'Exemple — série en cours',
                subtitle: 'S02 · E04 — 12 min restantes',
                backdropUrl: null,
                progress: 0.64,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

            SliverToBoxAdapter(
              child: ContentRail(
                title: 'Favoris',
                itemCount: 6,
                onSeeAll: () {},
                itemBuilder: (context, index) => MediaPosterCard(
                  title: 'Titre ${index + 1}',
                  posterUrl: null,
                  onTap: () {},
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

            SliverToBoxAdapter(
              child: ContentRail(
                title: 'Films d\'action',
                itemCount: 8,
                onSeeAll: () {},
                itemBuilder: (context, index) => MediaPosterCard(
                  title: 'Titre ${index + 1}',
                  posterUrl: null,
                  progress: index == 2 ? 0.3 : null,
                  onTap: () {},
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
          ],
        ),
      ),
    );
  }
}
