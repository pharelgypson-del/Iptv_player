import 'package:flutter/material.dart';
import 'theme.dart';

/// Écran Profil.
///
/// Regroupe : gestion des sources ajoutées (M3U / Xtream Codes),
/// paramètres du lecteur, contrôle parental, et une note informative
/// sur l'usage d'un VPN personnel — sans intégration VPN dans l'app.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profil'),
        leading: const BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
          vertical: AppSpacing.md,
        ),
        children: [
          const _SectionHeader('Sources'),
          _SettingsTile(
            icon: Icons.playlist_play_rounded,
            label: 'Gérer mes sources',
            sublabel: 'Playlists M3U et connexions Xtream Codes',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.add_circle_outline_rounded,
            label: 'Ajouter une source',
            onTap: () {},
          ),

          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader('Lecture'),
          _SettingsTile(
            icon: Icons.high_quality_outlined,
            label: 'Qualité par défaut',
            sublabel: 'Automatique',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.subtitles_outlined,
            label: 'Sous-titres',
            onTap: () {},
          ),

          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader('Sécurité'),
          _SettingsTile(
            icon: Icons.lock_outline_rounded,
            label: 'Contrôle parental',
            sublabel: 'Verrouillage par PIN',
            onTap: () {},
          ),

          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader('Réseau'),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded,
                    color: AppColors.textSecondary, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Cette application ne fournit ni n\'intègre de VPN. '
                    'Si votre connexion réseau le nécessite, activez '
                    'votre propre VPN avant de lancer la lecture.',
                    style: AppTypography.meta.copyWith(height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.meta.copyWith(
          letterSpacing: 0.8,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    this.sublabel,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? sublabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 22),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (sublabel != null)
                    Text(sublabel!, style: AppTypography.meta),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textTertiary, size: 20),
          ],
        ),
      ),
    );
  }
}
