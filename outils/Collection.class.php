<?php

class Collection{

    public function where($field, $sign, $val){

        $elmsClass = new Collection; $ind = 0;
        foreach ($this as $key => $value) {

            switch ($sign) {
                case '=':

                    if($value->{$field} == $val){
                        $elmsClass->{$ind} = $value;
                    } 

                    break;

                case '>':

                    if($value->{$field} > $val){
                        $elmsClass->{$ind} = $value;
                    } 
                        
                    break;    
                case '<':

                    if($value->{$field} < $val){
                        $elmsClass->{$ind} = $value;
                    } 
                            
                    break;                                     
                
                default:
                    
                    break;
            }
            $ind++;
        }

        return $elmsClass;

            
    }

    public function delete(){
        
        foreach ($this as $key => $value) {
            
            $modelClass = get_class($value);
            $modelClass::deleteItem($value);

        }

    }



    
}




?>