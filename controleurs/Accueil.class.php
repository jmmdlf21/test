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
		
		$data = Annonces::getAllAnnonces();

		return new Vue("accueil",array('data' => $data));

	}


}