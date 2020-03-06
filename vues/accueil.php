<?php

$this->titre = "Accueil";

?>

<div class="row justify-content-center">

    <div class="col-sm-4">

        <?php foreach($data as $annonce):?>

        <h3> <?=$annonce->titre?> </h3>
        <p> <?= $annonce->description?></p>

        <?php endforeach?>
            
    </div>

</div>


