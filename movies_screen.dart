import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets.dart';

/// Écran Films — grille poster 2:3, tri par récents/alphabétique/genre.
class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.md,
                AppSpacing.screenPadding,
                AppSpacing.sm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Films', style: AppTypography.displayLarge),
                  const Icon(Icons.sort_rounded,
                      color: AppColors.textSecondary),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                  vertical: AppSpacing.sm,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 0.62,
                ),
                itemCount: 18,
                itemBuilder: (context, index) => MediaPosterCard(
                  title: 'Film ${index + 1}',
                  posterUrl: null,
                  width: double.infinity,
                  onTap: () {
                    // TODO: fiche détail plein écran
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
