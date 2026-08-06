import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets.dart';

/// Écran TV en direct.
///
/// Grille de chaînes (fond neutre uniformisé, voir ChannelTile),
/// filtrage par catégorie en chips scrollables. Recherche en overlay
/// plein écran plutôt que barre permanente.
class LiveTvScreen extends StatefulWidget {
  const LiveTvScreen({super.key});

  @override
  State<LiveTvScreen> createState() => _LiveTvScreenState();
}

class _LiveTvScreenState extends State<LiveTvScreen> {
  int _selectedCategory = 0;
  final _categories = ['Toutes', 'Sport', 'Info', 'Divertissement', 'Kids'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
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
                  Text('TV en direct', style: AppTypography.displayLarge),
                  IconButton(
                    onPressed: () {
                      // TODO: ouvrir overlay de recherche plein écran
                    },
                    icon: const Icon(Icons.search_rounded),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                itemCount: _categories.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSpacing.xs),
                itemBuilder: (context, i) {
                  final selected = i == _selectedCategory;
                  return ChoiceChip(
                    label: Text(_categories[i]),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedCategory = i),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: AppSpacing.md,
                  crossAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 0.8,
                ),
                itemCount: 20,
                itemBuilder: (context, index) => ChannelTile(
                  name: 'Chaîne ${index + 1}',
                  logoUrl: null,
                  isLive: true,
                  onTap: () {
                    // TODO: pousser vers l'écran lecteur plein écran
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
