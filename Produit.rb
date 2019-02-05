# encoding: UTF-8

##
# Auteur GUENVER Yann
# Version 1.1 : Date : Tue Jan 15 10:57:11 CET 2018
#

# Cette classe permet de lire la liste des produits dans un fichier et la renvoyer

class Produit

	private_class_method :new

	def self.lire
		# Permet de lire un fichier contenant une liste des produits
		fichier = "./Produit/Produits.txt"
		# On ré initialise la liste des produits
		produits = Array.new

		# Lecture de l'ensemble du fichier
		lecture = File.readlines(fichier)
		lecture.each { |ligne|
			lesMots = ligne.split(' ')
			produits << lesMots
		}
		return produits
	end
end

Produit.lire.each{|x| p x}
