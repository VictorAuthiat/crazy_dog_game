Le jeu fou du chien c'est quoi ?

## I / Un petit appercu

On a 9 cartes qui ont chacunes 4 côtés.

On a toujours $n!$ façons différentes de permuter $n$ objets.

- Donc, qu'est-ce que c'est que $n!$ ?

  Le produit des nombres entiers strictement positifs inférieurs ou égaux à $n$.

- Qu'est-ce que permuter des objets ?

  Réarranger des objets d'une liste de manières discernables.

  **Exemple:**

    Avec une tableau `[1, 2, 3]` voici les permutations: (merci ruby)

    ```ruby
      [1, 2, 3].permutation.to_a
      # [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
    ```

Donc 9 cartes * 4 orientations possibles pour chaque carte.

ce qui donne:

$$ (9 * 4) * ( 8 * 4) * (7 * 4) * (6 * 4) * (5 * 4) * (4 * 4) * (3 * 4) * (2 * 4) * (1 * 4) $$

Étant donné que $n = 9$ alors on a 362 800 permutations * $4^9$.

Donc pour résumer si $n$ est égal au nombre de cartes, $i$ au nombre de côtés, et x au nombre de possibilités alors on a:

$$ x = n! * i^n $$
$$ x = 2 * 3 * 4 * 5 * 6 * 7 * 8 * 9 * 4^9 $$

_"Heureusement"_ comme on peut aussi tourner le puzzle dans les 4 sens on peut diviser le résultat par 4:

$$x = {n! * i^n \over i}$$

$$ x = 23781703680 $$

Pratiquement 24 milliards de possibilités...

Maintenant si on regarde de plus près on n'a pas vraiment besoin de vérifier toutes ces possibilités car les cartes ont une disposition particulière. Il y a toujours deux têtes et deux corps sur chaque carte et ça, c'est vraiment cool car ça réduit énormement le nombre de possibilités. enfaite on n'a plus besoin de multiplier par $i^n$, on a juste besoin que les cartes soient correctement installées au commencement du jeu !

On a donc:

$$ x = {n! \over i} $$

$$ x = {( 2 * 3 * 4 * 5 * 6 * 7 * 8 * 9) \over 4} $$
$$ x = 90720 $$

Plus que 90k possibilités !

### 2 / Du code du code du code

On veut maintenant représenter la donnée pour trouver la solution. On va donc:

  - Transformer les cartes en tableaux de chiffres.
  - Générer toutes les grilles necessaires.
  - Trouver les grilles valides.

Donc pour résumer, pour chaque grille il faut vérifier que les emplacements des cartes sont valides; c'est à dire que le côté inférieur et le côté droit sont cohérents avec le côté supérieur et le côté gauche des cartes adjacentes.

Représentation de la donnée:

J'ai préféré travailler avec des entiers plutôt que des symbols ou des strings car cela est plus rapide. (benchmark en ressource)

```
  --------------------------
 |  color   | body  | head  |
 |----------|-------|-------|
 |  grey    |   1   |   -1  |
 |  brown   |   2   |   -2  |
 |  orange  |   3   |   -3  |
 |  tabby   |   4   |   -4  |
  --------------------------
```

Donc à chaque fois un chiffre positif pour le corp et un chiffre négatif pour la tête.
Ce qui nous donne quelque chose comme ça:

```ruby
cards = [
  [-1, -4, 2, 3], [-2, -4, 2, 3], [-2, -3, 4, 1],
  [-1, -3, 2, 4], [-1, -3, 1, 4], [-2, -1, 3, 4],
  [-1, -2, 4, 3], [-2, -4, 1, 3], [-2, -4, 1, 3]
]
```

On va pouvoir maintenant run notre petit script et voir s'il trouve la solution:

```ruby
CrazyDogGame.run_example
```

✌️

---

Le souci c'est qu'il n'y a que 9 cartes dans notre grille, si nous en avions plus il arriverait un moment où même la plus puissante des machines ne pourrait pas trouver la solution dans un temps résonnable.

Pour une grille de 3x3 on a vu qu'il y a, avant traitement des grilles inutiles, 23781703680 possibilités.
Pour une grille de 6x6 on a 439 172 204 570 951 095 407 890 776 875 422 494 228 627 387 386 219 724 800 000 000 possibilités..

Comme vu précédemment avec un algo un peu moins 'naïf' on a donc:

Pour une grille de 3x3 on a 90 720 possibilités.
Pour une grille de 6x6 on a possibilités 92 998 331 697 475 304 366 999 862 037 708 800 000 000.

Si le calcul d'une opération prend une microseconde, alors le calcul de tous les possibilités pour 9 cartes est de 90720 microsecondes soit 0,09 seconde, mais pour 4 cartes (grille de 4x4), cela représente déjà 5 230 697 472 000 microsecondes soit près de 60 jours.

Nous sommes donc dans l'incapacité de résoudre ce problème lorsque le nombre d'entrées est trop important.

---

## Quelques ressources intéressantes:

**Benchmarck comparaison d'objets en Ruby:**

- http://andrewsblog.org/ruby-comparisons-benchmark/

**Complexité algorithmique:**

- https://becominghuman.ai/analyzing-algorithmic-complexity-1519488fbcff
- https://jackkrupansky.medium.com/what-is-algorithmic-complexity-or-computational-complexity-and-big-o-notation-9c1e5eb6ad48

**Problèmes P, NP, NP-complets, NP-difficiles etc**

- https://scienceetonnante.com/2020/07/17/est-ce-que-p-np/
- https://medium.com/@bilalaamir/p-vs-np-problem-in-a-nutshell-dbf08133bec5
- https://en.wikipedia.org/wiki/Travelling_salesman_problem
