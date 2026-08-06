# Lecteur IPTV — prototype

Lecteur IPTV personnel, local-first (aucun compte, aucun backend).
L'utilisateur ajoute ses propres sources M3U ou Xtream Codes ; l'app se
charge uniquement de l'organisation et de la lecture.

## Installation

Prérequis : Flutter 3.19+ installé (`flutter doctor` sans erreur bloquante).

```bash
flutter pub get
flutter run
```

Sur Linux desktop ou Android, `media_kit` nécessite parfois l'installation
des libs mpv natives — voir la doc du package si `flutter run` échoue au
lancement du lecteur :
https://pub.dev/packages/media_kit_libs_video

## État d'avancement (cette itération)

Fait :
- Design system complet (couleurs, typographie, métriques, thème Material 3)
- Composants réutilisables : `MediaPosterCard`, `ChannelTile`, `ContentRail`,
  `ResumeHeroCard`
- 5 écrans : Accueil, TV en direct, Films, Séries, Profil
- Navigation (bottom bar + route Profil) via `go_router`
- `main.dart` avec initialisation `media_kit`

Volontairement non fait (prochaine itération) :
- Parsing M3U réel et client Xtream Codes (`core/data/`)
- Persistance locale Drift (catalogue, favoris, historique)
- Stockage sécurisé des identifiants (`flutter_secure_storage`)
- Écran lecteur vidéo plein écran (gestes, sous-titres, reprise de lecture)
- Fiche détail film/série (synopsis, sélecteur de saison, épisodes)
- Overlay de recherche
- Contrôle parental (verrouillage PIN)

Tous les écrans actuels utilisent des données factices (`posterUrl: null`,
listes de longueur fixe) — c'est volontaire, l'objectif de cette passe est
de valider la direction visuelle avant d'investir dans la couche données.

## Police

Le thème référence les familles `GeneralSans` (titres) et `Inter` (corps).
Ce ne sont pas des polices système : à ajouter en asset (voir note dans
`lib/core/theme/app_typography.dart`) ou remplacer par `null` pour utiliser
la police système par défaut en attendant.

## Notes d'architecture

- **State management** : Riverpod (`ProviderScope` déjà en place dans
  `main.dart`, aucun provider métier créé pour l'instant).
- **Navigation** : `go_router`, une seule route poussée (`/profile`) en
  plus du shell principal.
- **Lecteur vidéo** : `media_kit` (libmpv) choisi pour sa tolérance aux
  flux TS/HLS irréguliers typiques de l'IPTV, au détriment de
  `video_player` natif.
