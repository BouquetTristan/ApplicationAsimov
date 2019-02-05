# encoding: UTF-8

##
# Auteur BOUQUET Tristan
# Version 1.1 : Date : Thu Dec 20 18:30:18 CET 2018
#

# Application permettant de prendre commande à la caféteria
#
# Cette application permet d'entrer un produit qui sera enregistré dans un fichier annexe
# Un fichier servira de base de donnée pour stocker les caractéristiques de tous les produits en vente
# Pour l'utiliser, l'utilisateur doit entrer le nom du produit, la quantité et le statut de l'acheteur
# Le nom est recherché dans une base de donnée avec le nom de tous les produits en vente
# La quantité est un chiffre supérieur à 0
# Le statut est une chaine de caractère qui ne peut avoir que deux réponses possibles "membre", "non membre"



load "Commande.rb"

class Cafeteria

	# Cette méthode demande :
	#	- le nom d'un produit (voir bdd),
	#	- la quantité (1 ou plus),
	#	- le statut de l'acheteur (membre, non membre)

	# Tous les statuts possibles
	statutMembre = "membre"
	statutNonMembre = "non membre"
	produitSup = ""

	while (true)

		# Nom du produit de la commande
		print "	Nom : "
		unProduit = gets.chomp
		unProduit = unProduit.downcase
		unProduit = unProduit.split(' ').join
		# Vérification si le produit est un repas (Si oui, on demande la saisie du produit supplémentaire
		if unProduit == "burger" || unProduit == "lasagne" || unProduit == "blanquette" || unProduit == "cassoulet" then
			print "	Produit supplémentaire : "
			produitSup = gets.chomp
		end

		# Quantité du produit de la commande
		print "	Quantité : "
		uneQuantite = gets.chomp
		# Mise à défaut de quantité si aucune quantité n'a été précisée
		if uneQuantite.to_s == "" then
			uneQuantite = 1
		else
			while uneQuantite.to_i < 1 do
				print "Erreur, la quantité doit être supérieur à 0\n	Quantité : "
				uneQuantite = gets.chomp
			end
		end


		begin
			# Statut de l'acheteur de la commande
			print "	Membre ? (y/n): "
			unStatut = gets.chomp
			# Mise à défaut de statut si aucun statut n'a été précisé
			if unStatut.to_s == "" || unStatut == "y" then
				unStatut = statutMembre
			elsif unStatut == "n" then
				unStatut = statutNonMembre
			else
				print " Erreur "
			end
		end while unStatut != statutMembre && unStatut != statutNonMembre


		# Création de la commande et récupération du prix en fonction du statut de la personne
		laCommande = Commande.creer(unProduit, uneQuantite, unStatut)
		prixUnitaire = laCommande.valider(unProduit, unStatut)

		if prixUnitaire.to_s != "0.0" then

			# Affichage du prix total
			prixTotal = prixUnitaire.to_f*uneQuantite.to_i

			print "\n	Prix de la commande : #{prixTotal}€\n"

			# Ecriture de la commande dans un fichier txt
			laCommande.ecrire(unProduit, produitSup, uneQuantite, prixUnitaire)
			laCommande.ecrireProduitJournalier(unProduit, produitSup, uneQuantite, unStatut)
			produitSup.to_s.clear

		else
			print "Erreur, le prix n'est de "+unProduit+" n'est pas reconnu\n"
		end

		print "\n\n\n\n"
		print "==========NOUVELLE COMMANDE==========\n"
	end


end # Marqueur de fin de classe
