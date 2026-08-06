import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets.dart';

/// Écran Séries — grille poster, même grammaire visuelle que Films.
class SeriesScreen extends StatelessWidget {
  const SeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.md,
                AppSpacing.screenPadding,
                AppSpacing.sm,
              ),
              child: Text('Séries', style: AppTypography.displayLarge),
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
                itemCount: 15,
                itemBuilder: (context, index) => MediaPosterCard(
                  title: 'Série ${index + 1}',
                  posterUrl: null,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
