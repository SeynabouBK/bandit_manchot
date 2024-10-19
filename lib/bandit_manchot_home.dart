import 'package:flutter/material.dart';
import 'dart:math';

class BanditManchotHomePage extends StatefulWidget {
  const BanditManchotHomePage({super.key, required this.title});

  final String title;

  @override
  State<BanditManchotHomePage> createState() => _BanditManchotHomePageState();
}

class _BanditManchotHomePageState extends State<BanditManchotHomePage> {
  List<String> images = [
    'images/bar.png',
    'images/cerise.png',
    'images/cloche.png',
    'images/diamant.png',
    'images/fer-a-cheval.png',
    'images/pasteque.png',
    'images/sept.png',
  ];

  List<String> displayedImages =
      []; //Contient les trois images actuellement visibles.//
  Random random = Random();

  bool isPlaying =
      false; //je vais désactiver le bouton une fois cliqué et le réactiver après la durée du SnackBar.

//L’avantage d’utiliser initState() est que cela ne se produit qu'une seule fois, au tout début, ce qui est pratique lorsque l'on veut faire des préparations qui ne changent pas souvent.
  @override
  void initState() {
    //Utilisée pour initialiser l'état du widget avec trois images aléatoires au lancement de l'application. cela signifie que nous prenons une fonction (initState()) qui existe déjà dans la classe de base, et nous la personnalisons pour l’utiliser dans notre propre contexte.
    super.initState();
    // Initialiser avec trois images aléatoires, change à chaque fois qu'on rafraichit la page
    displayedImages = List.generate(
        3,
        (index) => images[random.nextInt(images
            .length)]); //random.nextInt(images.length) génère un nombre aléatoire compris entre 0 et le nombre total d’images dans notre liste (images). Chaque nombre correspond à une position dans la liste images.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                AnimatedSwitcher(
                  //Ce widget est utilisé pour effectuer une transition animée chaque fois que l'enfant du widget change. Ici, je l utilise pour chaque image afin d'avoir une animation lors de la mise à jour des symboles.
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: //Utilisé pour définir le type d'animation de transition. j utilise un ScaleTransition pour donner l'effet de zoom avant/arrière des images.
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Image.asset(
                    displayedImages[i],
                    key: ValueKey<String>(displayedImages[
                        i]), //Assure que chaque image est traitée comme une entité unique, ce qui permet à Flutter de savoir quelles images ont changé. ValueKey<String> car chaque image est représentée par une chaîne de caractères (le chemin du fichier d'image),
                    width: 80,
                    height: 80,
                  ),
                ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: const TextStyle(fontSize: 24),
            ),
            onPressed: isPlaying
                ? null // Désactivation du bouton pendant que le jeu est en cours, le bouton est désactivé (null empêche l'utilisateur de cliquer dessus
                : () {
                    setState(() {
                      isPlaying = true; // Désactivation du bouton

                      // Généreration de trois nouvelles images aléatoires
                      displayedImages = List.generate(
                          3, (index) => images[random.nextInt(images.length)]);

                      // Vérification: si les trois images sont identiques
                      if (displayedImages[0] == displayedImages[1] &&
                          displayedImages[1] == displayedImages[2]) {
                        // Affichage d un message de Jackpot
                        if (displayedImages[0] == 'images/sept.png') {
                          // Animation spéciale pour le Jackpot avec le symbole 7
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Jackpot spécial avec le symbole 7 ! 🥳',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.yellow),
                              ),
                              backgroundColor: Colors.purple,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          // Affichage d'un message de Jackpot normal
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Jackpot ! Vous avez gagné ! :)',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2), //
                            ),
                          );
                        }
                      } else {
                        // Affichage d un message de perte
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Dommage, essayez encore ! :(',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            backgroundColor:
                                Colors.red, // Définition: une couleur de fond
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }

                      // Réactivation: le bouton après la durée du SnackBar
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          isPlaying =
                              false; // Réactivation: le bouton après 2 secondes
                        });
                      });
                    });
                  },
            child: const Text('Jouer'),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
              "le bouton 'Jouer' sera désactivé après chaque clic, ce qui empêche l'utilisateur de cliquer trop rapidement. Ainsi, le message affiché sera en concordance avec l état des images visibles à l écran.")
        ],
      ),
    );
  }
}
