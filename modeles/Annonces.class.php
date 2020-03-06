<?php

class Annonces extends Model{

    protected $fillAttributes = ['annonce_id', 'annonce_titre', 'annonce_description', 'annonce_prix', 'categorie_id', 'usager_id'];

    public static function getAllAnnonces(){

        return Annonces::getAll();

    }

    public static function getAnnonce($id){

        return Annonces::getItem($id);
        
    }

    public function putAnnonce(){

        Annonces::putItem($this);

    }

    public function postAnnonce(){

        Annonces::postItem($this);

    }

    public function deleteAnnonce(){

        Annonces::deleteItem($this);

    }

    public static function whereAnnonce($field, $sign, $val){

        return Annonces::where($field,$sign,$val);        
        
    }







}

?>