<?php

class Utilisateurs {

    /**
     * Récupération des lignes d'une table 
     *
	 * @return array
     */
    public function getTable($table) {
        $sPDO = SingletonPDO::getInstance();
		$oPDOStatement = $sPDO->prepare("SELECT * FROM $table ORDER BY ordre ASC");
        $oPDOStatement->execute();
        return $oPDOStatement->fetchAll(PDO::FETCH_ASSOC);
    }    



}


?>