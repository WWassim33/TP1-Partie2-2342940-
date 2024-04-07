-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom: WASSIM BOUCHAKOUR      Votre DA: 2342940
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC OUTILS_OUTIL;
REPONSE:

 DESC outils_usager;
DESC outils_emprunt;
DESC OUTILS_OUTIL;

-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
SELECT ...

REPONSE: 
SELECT CONCAT(prenom, ' ', nom_famille) AS "Nom Complet"
FROM outils_usager;

-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
REPONSE: 
SELECT DISTINCT ville AS "Ville"
FROM outils_usager
ORDER BY ville;

-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
REPONSE: 
SELECT *
FROM outils_outil
ORDER BY nom, code_outil;

-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
REPONSE: 
SELECT num_emprunt AS "Numéro d'emprunt"
FROM outils_emprunt
WHERE date_retour IS NULL;

-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3
REPONSE:
SELECT num_emprunt AS "Numéro d'emprunt"
FROM outils_emprunt
WHERE date_emprunt < '2014-01-01';

-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
REPONSE:
SELECT nom AS "Nom de l'outil",
       code_outil AS "Code de l'outil"
FROM outils_outil
WHERE  UPPER(caracteristiques) LIKE '%J%';

-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
REPONSE:
SELECT nom AS "Nom de l'outil",
       code_outil AS "Code de l'outil"
FROM outils_outil
WHERE fabricant LIKE 'Stanley';

-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
REPONSE:
SELECT nom AS "Nom de l'outil",
       fabricant AS "Fabricant"
FROM outils_outil
WHERE annee BETWEEN 2006 AND 2008;


-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
REPONSE:
SELECT code_outil AS "Code de l'outil",
       nom AS "Nom de l'outil"
FROM outils_outil
WHERE caracteristiques NOT LIKE '%20 volt%';

-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
REPONSE:
-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita

SELECT COUNT(*) AS "Nombre outil"
FROM outils_outil
WHERE fabricant NOT LIKE 'Makita';

-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
REPONse:
SELECT u.nom_famille AS "Nom de famille",
       u.prenom AS "Prénom",
       e.num_emprunt AS "Numéro d'emprunt",
       (e.date_retour - e.date_emprunt) AS "Duréé d'emprunt",
       o.prix AS "Prix de l'outil"
FROM outils_emprunt e
JOIN outils_outil o
ON e.code_outil = o.code_outil
 JOIN outils_usager u
ON e.num_usager = u.num_usager
WHERE u.ville IN('Vancouver','Regina');

-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
REPONSE:
SELECT e.code_outil AS "Code de l'outil",
       o.nom AS "Nom de l'outil"
FROM outils_outil o
JOIN outils_emprunt e
ON o.code_outil = e.code_outil
WHERE e.date_retour IS NULL;

-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
REPONSE:
SELECT nom_famille AS "Nom de famille",
       courriel AS "Courriel"
FROM outils_usager 
WHERE num_usager NOT IN(SELECT num_usager
                        FROM outils_emprunt);

-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
REPONSE:
SELECT o.code_outil AS "Code de l'outil",
       COALESCE(o.prix, 0) AS "PRIX"
FROM outils_outil o
LEFT OUTER JOIN outils_emprunt e
ON o.code_outil = e.code_outil
WHERE e.code_outil IS NULL;

-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
REPONSE:
SELECT nom AS "Nom",
       COALESCE(prix, (SELECT AVG(prix) 
                    FROM outils_outil 
                    WHERE fabricant = 'Makita')) AS "Prix"
FROM  outils_outil
WHERE fabricant = 'Makita' AND (prix > (SELECT AVG(prix) 
                                FROM outils_outil 
                                WHERE fabricant = 'Makita') OR prix IS NULL);

-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
REPONSE:
SELECT u.nom_famille AS "Nom",
       u.prenom AS "Prénom",
       u.adresse AS "Adresse",
       o.code_outil AS "Code de l'outil",
       o.nom AS "Nom de l'outil"
FROM outils_usager u
JOIN outils_emprunt e 
ON u.num_usager = e.num_usager
JOIN outils_outil o 
ON e.code_outil = o.code_outil
WHERE e.date_emprunt >= '2015-01-01' 
ORDER BY u.nom_famille;

-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
REPONSE:
SELECT o.nom AS "Nom de l'outil",
       o.prix AS "Prix"
FROM outils_outil o
JOIN outils_emprunt e ON e.code_outil = o.code_outil
GROUP BY o.nom, o.prix
HAVING COUNT(e.code_outil) > 1;

-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure
SELECT u.nom_famille AS "Nom",
       u.adresse AS "Adresse",
       u.ville AS "Ville"
FROM  outils_usager u
JOIN  outils_emprunt e
ON u.num_usager = e.num_usager;

--  IN
SELECT  nom_famille AS "Nom",
        adresse AS "Adresse",
        ville AS "Ville"
FROM outils_usager
WHERE num_usager IN (SELECT num_usager 
                    FROM outils_emprunt);

--  EXISTS
SELECT nom_famille AS "Nom",
       adresse AS "Adresse",
       ville AS "Ville"
FROM outils_usager u
WHERE EXISTS (
        SELECT 1 
        FROM outils_emprunt e 
        WHERE e.num_usager = u.num_usager);

-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3

SELECT 
    fabricant AS "Marque",
    AVG(prix) AS "Moyenne des prix"
FROM outils_outil
GROUP BY fabricant;

-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4

SELECT u.ville AS "Ville",
       SUM(o.prix) AS "Somme des prix"
FROM outils_usager u
JOIN outils_emprunt e 
ON u.num_usager = e.num_usager
JOIN outils_outil o 
ON e.code_outil = o.code_outil
GROUP BY u.ville
ORDER BY SUM(o.prix) DESC;

-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO outils_outil (CODE_OUTIL, NOM, FABRICANT, CARACTERISTIQUES, ANNEE, PRIX)
VALUES ('TOOL123', 'Perceuse sans fil', 'Bosch', 'Perceuse électrique, sans fil, batterie lithium-ion', 2023, 149.99); 
-- j'ai mis un exemple d'outil

-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2

INSERT INTO outils_outil (CODE_OUTIL, NOM, ANNEE)
VALUES ('Nouveau_code', 'Nom_de_l_outil', 2024);

-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2

DELETE FROM outils_outil
WHERE CODE_OUTIL IN ('TOOL123', 'Nouveau_code');
-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2

UPDATE outils_usager
SET nom_famille = UPPER(nom_famille);
