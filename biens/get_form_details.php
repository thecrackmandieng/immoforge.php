<?php

use Taf\TafAuth;

try {
    require './config.php';
    require '../taf_auth/TafAuth.php';
    $taf_auth = new TafAuth();
    /* 
        $params
        contient tous les parametres envoyés par la methode POST
     */
    // toutes les actions nécéssitent une authentification
    $auth_reponse = $taf_auth->check_auth();
    if ($auth_reponse["status"] == false && count($params) == 0) {
        echo json_encode($auth_reponse);
        die;
    }

    $reponse["data"]["les_userss"] = $taf_config->get_db()->query("select * from users")->fetchAll(PDO::FETCH_ASSOC);
$reponse["data"]["les_types_biens"] = $taf_config->get_db()->query("select * from types_bien")->fetchAll(PDO::FETCH_ASSOC);
$reponse["data"]["les_etats_biens"] = $taf_config->get_db()->query("select * from etats_bien")->fetchAll(PDO::FETCH_ASSOC);
$reponse["data"]["les_statut_validation_biens"] = $taf_config->get_db()->query("select * from statut_validation_bien")->fetchAll(PDO::FETCH_ASSOC);
$reponse["data"]["les_regionss"] = $taf_config->get_db()->query("select * from regions")->fetchAll(PDO::FETCH_ASSOC);
$reponse["data"]["les_zoness"] = $taf_config->get_db()->query("select * from zones")->fetchAll(PDO::FETCH_ASSOC);


    $reponse["status"] = true;

    echo json_encode($reponse);
} catch (\Throwable $th) {
    $reponse["status"] = false;
    $reponse["erreur"] = $th->getMessage();

    echo json_encode($reponse);
}
