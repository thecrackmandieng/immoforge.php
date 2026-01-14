<?php

use Taf\TafAuth;

// Handle preflight OPTIONS request for CORS
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    header("Access-Control-Allow-Origin: http://localhost:4200");

    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Headers: Content-Type, Authorization');
    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
    header('Access-Control-Allow-Credentials: true');
    exit(0);
}

try {
    require '../TafConfig.php';
    $reponse = array();
    $table_name = "bien_documents";
    $taf_config = new \Taf\TafConfig();
    $taf_config->allow_cors();
    if (file_get_contents('php://input')=="") {
        $params=[];
    } else {
        $params=json_decode(file_get_contents('php://input'),true);
    }    
} catch (\Throwable $th) {
    echo "<h1>" . $th->getMessage() . "</h1>";
}
