# encoding: UTF-8

##
# Auteur BOUQUET Tristan
# Version 1.1 : Date : Thu Dec 20 18:30:18 CET 2018
#

# Cette classe permet de vérifier les entrées des commandes et de les sauvegarder
# La méthode valider va trouver le prix de l'article dans une base de donnée en fonction du statut de la personne
#   et va le renvoyer
#   Le fichier de la base de donnée est "Produit.txt"
# La méthode ecrire permet d'écrire la commande dans un fichier txt avec pour nom la date d'aujourd'hui sous
#   forme "dd-mm"


class Commande

	def Commande.creer(unNom, uneQuantite, unStatut)
		new(unNom, uneQuantite, unStatut)
	end
	private_class_method :new

	def initialize(unNom, uneQuantite, unStatut)
		@nom, @quantite, @statut = unNom, uneQuantite, unStatut
	end

	def valider(unProduit, unStatut)
		# Cette méthode recherche le nom du produit et, s'il le trouve,
		# récupère le prix du produit en fonction du statut du membre
		# Le fichier sauvegarde la commande dans un fichier txt avec
		#	le nom du produit
		#	la quantité
		#	le produit
		#	la date
		# Enfin, le fichier renvoie le prix total de la commande
		# Si le nom du produit n'est pas trouvé dans la base de donnée,
		# une erreur est envoyée en précisant qu'il ne connait pas le produit
		dossierProduit = "./Produit/"
		nomDuFichier = dossierProduit+"Produit.txt"

			# Lecture d'une ligne
		lecture = File.open(nomDuFichier, "r").readline
		#puts lecture

		# Lecture de l'ensemble du fichier
		lecture = File.readlines(nomDuFichier)
		lecture.each { |ligne|
			lesMots = ligne.split('><')
			if unProduit == lesMots[1] then
				if unStatut == "membre" then
					return lesMots[2]
				else
					return lesMots[3]
				end
			end
		}
		return "0.0"
	end

	def ecrire(unProduit, produitSup, uneQuantite, unPrix)

		nomFichierFacture = dateFichier()
		#print nomFichierFacture

		dossierFacture = "./Facture/"
		nomDuChemin = dossierFacture+nomFichierFacture

		#File::new(nomFichierFacture, "a+")
		leFichier = File.open(nomDuChemin, "a+")
		leFichier.write unProduit+" "+produitSup+"      "+uneQuantite.to_s+"        "+unPrix+"\n"
		leFichier.close
	end

	# But : écrire le nombre de vente d'un produit dans un fichier en fonction du statut de l'achat (membre, non membre)

	def ecrireProduitJournalier(unProduit, unProduitSup, uneQuantite, unStatut)

		nomFichierFacture = dateFichier()
		#print nomFichierFacture

		dossierFacture = "./FactureJournaliere/"
		print unStatut
		if unStatut == "membre" then
			dossierSatut = "Membre/"
		else
			dossierSatut = "NonMembre/"
		end
		nomDuChemin = dossierFacture+dossierSatut+nomFichierFacture

		if File.exist?(nomDuChemin) then

			# Lecture de l'ensemble du fichier
			b = false # Booleen qui permet de savoir si le produit a déjà une entrée
			fichier = File.open(nomDuChemin, "r+")
			lecture = fichier.readlines
			# On lit chaque entrée (ligne) du fichier
			lecture.map! { |ligne|
				ligne = ligne.split(' ')
				if unProduit == ligne[0] && !b then
					# Si le produit a déjà une entrée, on y ajoute le nombre de vente de la commande
					b = true
					ligne[1] = (ligne[1].to_i + uneQuantite.to_i).to_s # Addition et convertion en string
				end
				ligne
			}
			unless b then
				# Si le produit n'avais pas d'entrée, on fait une nouvelle entrée
				fichier.write unProduit+"      "+uneQuantite.to_s+"\n"
				fichier.close
			else
				# Sinon, on réécrit les entrées dans le fichier
				# (à chercher pour une simple réécriture de l'entrée désirée)
				fichier = File.open(nomDuChemin, "w")
				lecture.each{ |ligne|
					fichier.write ligne[0]+"      "+ligne[1]+"\n"
				}
				fichier.close
			end

		else
			# Si le fichier n'existe pas, on le créé puis on y écrit la première entrée
			fichier = File.open(nomDuChemin, "a+")
			fichier.write unProduit+"      "+uneQuantite.to_s+"\n"
			fichier.close
		end
	end

	def dateFichier()
		require 'date'

		dt = DateTime.now
		dateNom = dt.day.to_s+"-"+dt.month.to_s+".txt"
		#print dateNom
		return dateNom
	end

	def to_s
		return "Nom : #{@nom}	Quantité : #{@quantite}	Statut : #{@statut}\n"
	end

end # Marqueur de fin de classe
