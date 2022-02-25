# Appsonews
## Test technique Flutter

Appsonews est une application qui retransmet les actualités grâce à l'API. [newsapi.org](https://newsapi.org/).

## Installation
Avoir Flutter d'installé, cliquer sur Run.

## Consignes
> - Une liste paginée de toutes les actualités affichées sous forme de liste,
    avec des cellules composées d’une image, un titre et la source (si information
    disponible).
> - Une vue de détails d’une actualité contenant toutes les informations que vous jugerez
    utiles
> - Un système de favoris rendant disponible une actualité hors-ligne (images et contenu de
    la vue de détails).
> - Un système de partage de lien
> - Un système de redirection vers la page de l’article complet.

## Stack technique
Utilisation de [Flutter](https://flutter.dev/) et de [Firebase](https://firebase.google.com/)

## Recommandation
Utilisation de l'architecture MVVM Modèle Vue Modèle.
[En savoir plus](https://medium.com/flutterworld/flutter-mvvm-architecture-f8bed2521958)


## Dépendances

| Plugin | Fonctionnalité |
| ------ | ------ |
| provider ^6.0.2| Gestionnaire d'état |
| dio ^4.0.4 | Client HTTP |
| share_plus ^3.1.0| Gestion de partage de lien |
| url_launcher ^6.0.20| Ouverture de d'hyperlien |
| shared_preferences  ^2.0.13| Sauvegarde de données locale |
| palette_generator ^0.3.3 | Ajustement de la couleur du text |
| cached_network_image  | Sauvegarde en cache des image |
| firebase_core  | Initilisation de Firebase |
| firebase_dynamic_links  | Ouverture automatique de l'application si le lien n'existe pas |
