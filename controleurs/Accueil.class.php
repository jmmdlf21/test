<?php

/**
 * Classe Contrôleur 
 *
 */

class Accueil {

	/**
	 * Accueil
	 *
	 */
	public function index() {


		// Put annonce

		$att2 = array("annonce_id"=>4, "annonce_description"=>"test description2222");
		$test2 = new Annonces($att2);
		$test2->putAnnonce();

		// Post annonce
		/*
		$att = array("annonce_id"=>4, "annonce_titre"=>"test titre", "annonce_description"=>"test description", "annonce_prix"=>100, "categorie_id"=>1, "usager_id"=>1);
		$test2 = new Annonces($att);
		$test2->postAnnonce();
		*/
		
		// Delete annonce
		/*
		$test = Annonces::getAnnonce(3);
		$test->deleteAnnonce();
		*/

		// Get une annonce
		$data = Annonces::getAnnonce(1);

		return new Vue("accueil",array('data' => $data));

	}


}