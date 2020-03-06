<?php

/**
 * Classe Model, accès PDO aux tables MySQL
 *
 */

abstract class Model {

    protected $table;
    protected $fillAttributes = array();

    public function __construct($attributes = null){
        if($attributes !== null){

            foreach ($attributes as $key => $value) {
                $this->addProperty($key, $value);
            }
        }

        $this->table = get_class($this);

    }

    private function addProperty($key, $value){

        $this->{$key} = $value;

    }

     /**
     * Récupération des lignes d'une table 
     *
	 * @return Collection d'un enfant ou enfants de classe 'Model'
     */
    public static function getAll() {
        $tabName = get_called_class();

        $sPDO = SingletonPDO::getInstance();
		$oPDOStatement = $sPDO->prepare("SELECT * FROM $tabName");
        $oPDOStatement->execute();

        $elmsClass = new Collection; $ind = 0;
        foreach($oPDOStatement->fetchAll(PDO::FETCH_ASSOC) as $data){

            $elmClass = new $tabName($data);
            $elmsClass->{$ind}=$elmClass; $ind++;
            
        }

        return $elmsClass;
    }


    /**
     * Récupération d'un item 
     *
	 * @return un enfant de classe 'Model'
     */
    public static function getItem($id) {
        $tabName = get_called_class();
        $sPDO = SingletonPDO::getInstance();
        $prefix = substr($tabName, 0, -1);
        $oPDOStatement = $sPDO->prepare("SELECT * FROM $tabName WHERE ".$prefix."_id=:id"); 
        $oPDOStatement->bindValue(':id', $id); 
        $oPDOStatement->execute();

        $data = $oPDOStatement->fetch(PDO::FETCH_ASSOC);
        $elmClass = new $tabName($data);

        return $elmClass;
    }    

   
    /**
     * Ajout d'un item dans une table
     *
	 * @return boolean false si item n'a été ajouté dans la table principale, true sinon
     */
    public static function postItem($elmClass) { 
        try{
            $tabName = get_called_class();
            $prefix = substr($tabName, 0, -1);

            $sPDO = SingletonPDO::getInstance();
            $req = "INSERT INTO $tabName SET ";

            foreach($elmClass as $key => $value){
                if(in_array($key, $elmClass->fillAttributes)){

                    $req .= $key."=:".$key.", ";

                }
            }

            $req = substr($req, 0, -2); 

            $oPDOStatement = $sPDO->prepare($req);

            foreach($elmClass as $key => $value){
                if(in_array($key, $elmClass->fillAttributes)){

                    $oPDOStatement->bindValue(":".$key, $value);

                }
            }        
            
            $oPDOStatement->execute();
            if ($oPDOStatement->rowCount() == 0) {
                return false;
            } else {
                return true;
            }


        }catch(\Throwable $th){

            echo "<h4>Ajouter des noms de champ à propriété fillAttributes dans le modèle $tabName pour bien fonctionné method postItem </h4>";

        }

           
    }
    
    /**
     * Modification d'un item dans une table
     *
	 * @return boolean false si item n'a été modifié dans la table principale, true sinon
     */
    public static function putItem($elmClass) {
        try{        
            $tabName = get_called_class();

            $sPDO = SingletonPDO::getInstance();
            $req = "UPDATE $tabName SET ";

            foreach($elmClass as $key => $value){
                if(in_array($key, $elmClass->fillAttributes)){

                    $req .= $key."=:".$key.", ";

                }
            }

            $req  = substr($req, 0, -2);
            $req .= " WHERE ".$tabName."_id=".$elmClass->{strtolower($tabName)."_id"}; 
            $oPDOStatement = $sPDO->prepare($req);

            foreach($elmClass as $key => $value){
                if(in_array($key, $elmClass->fillAttributes)){

                    $oPDOStatement->bindValue(":".$key, $value);

                }
            } 

            $oPDOStatement->execute();
            if ($oPDOStatement->rowCount() == 0) {
                return false;
            } else {
                return true;
            }
        }catch(\Throwable $th){

            echo "<h4>Ajouter des noms de champ à propriété fillAttributes dans le modèle $tabName pour bien fonctionné method putItem </h4>";

        }        
    }   
    
    /**
     * Supprimant d'un item dans une table
     *
	 * @return boolean false si item n'a été supprimé dans la table principale, true sinon
     */
    public static function deleteItem($elmClass) {
        $tabName = get_called_class();
        $sPDO = SingletonPDO::getInstance();
        $prefix = substr($tabName, 0, -1);
        $req = "DELETE FROM $tabName WHERE ".$prefix."_id=".$elmClass->{strtolower($prefix)."_id"};
        $oPDOStatement = $sPDO->prepare($req);
        $oPDOStatement->execute();
        if ($oPDOStatement->rowCount() == 0) {
			return false;
        } else {
			return true;
        }
        
    } 


    /**
     * Recherche d'un ou plusieur items dans une table
     *
	 * @return Collection d'un enfant ou enfants de classe 'Model'
     */
    public static function where($field,$sign,$value) {
        $tabName = get_called_class();

        $sPDO = SingletonPDO::getInstance();
        $oPDOStatement = $sPDO->prepare("SELECT * FROM $tabName WHERE $field $sign:val");
        $oPDOStatement->bindValue(':val',$value);        
        $oPDOStatement->execute();

        $elmsClass = new Collection; $ind = 0;
        foreach($oPDOStatement->fetchAll(PDO::FETCH_ASSOC) as $data){

            $elmClass = new $tabName($data);
            $elmsClass->{$ind}=$elmClass; $ind++;
            
        }

        return $elmsClass;       
        
    }


 

}