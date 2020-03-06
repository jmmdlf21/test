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
		
		// Delete annonce
		$test = Annonces::getAnnonce(3);
		$test->deleteAnnonce();

		// Post annonce

		// Get une annonce
		$data = Annonces::getAnnonce(1);

		return new Vue("accueil",array('data' => $data));

	}


}