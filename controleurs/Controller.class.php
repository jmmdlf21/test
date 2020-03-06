<?php

class Controller{

// public static $errors = null;    

// public function __construct($errors = null){

//     self::$errors = $errors;

// }    

public function validate($attributes=null){

    $valide = true;
    $errors = array();

    if($attributes !== null){

        foreach($attributes as $key => $value){

            $arr = explode('|',$value);
            foreach($arr as $verify){

                if($verify == "required"){

                    if(isset($_POST[$key])){
                        if($_POST[$key] == ""){
                            $valide = false;
                            array_push($errors, [$key => $_POST[$key]]);                            
                        }
                    }                    

                }

                if(preg_match('/min/',$verify)){

                    

                }

                

            }
            

        }


    }

    if(!$valide){
        
        return $this->arrayToObject($errors);
        
    }else return $_POST;


}

public function arrayToObject($array){

    $result = array();
    foreach($array as $arr){

        foreach($arr as $key => $value){

            $result[$key] = $value;

        }

    }

  return $result; 

}

}



?>