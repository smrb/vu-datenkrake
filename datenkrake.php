<?php // Datenkrake.php by SmR.b v1.2.1

/* Enter your server specific data */
define("DB_HOST", "YOUR_DB_HOST");
define("DB_USER", "YOUR_DB_USER");
define("DB_PASS", "YOUR_DB_PASS");
define("DB_NAME", "YOUR_DB_NAME");

function curr_round($db){
    $res = $db->query("SELECT id FROM Rounds WHERE round_end IS NULL ORDER BY id DESC LIMIT 1");
    if($res->num_rows < 1)
        $res = $db->query("SELECT id FROM Rounds ORDER BY id DESC LIMIT 1");

    $r = $res->fetch_assoc();
    $res->close();
    return intval($r["id"]);
}
function curr_conn($db, $name){
    $res = $db->query("SELECT * FROM Connectionss WHERE name = '".$db->escape_string($name)."' ORDER BY id DESC LIMIT 1");
    if($res->num_rows < 1)
        $res = $db->query("SELECT id FROM Rounds ORDER BY id DESC LIMIT 1");

    $r = $res->fetch_assoc();
    $res->close();
    return intval($r["id"]);
}

function ROUND_START($db){
    $db->query("INSERT INTO Rounds (round_start, round_end, map, gamemode, players_max, players_start, players_end)
    VALUES (NOW(), NULL, '".$db->escape_string($_GET['name'])."',
                   '".$db->escape_string($_GET['mode'])."', 0, 0, 0)");
}
function ROUND_END($db){
    $db->query("UPDATE Rounds SET round_end = NOW(), players_end = " . intval($_GET["players"]) . " WHERE round_end IS NULL ORDER BY ID DESC LIMIT 1" );
}
function PLAYER_JOINED($db){
    $res = $db->query("INSERT INTO Connections (connection_start, connection_end, player_name, guid, ping, players_total)
    VALUES (NOW(), NULL, '".$db->escape_string($_GET["name"])."',
    '".$db->escape_string($_GET["guid"])."', ".intval($_GET["ping"]).",
    ".intval($_GET["pall"]).")");
    $con = $res->insert_id;
    var_dump($db);
    $res->close();
    $r = curr_round($db);
    $db->query("UPDATE Rounds SET players_max = " . intval($_GET["pall"]) . " WHERE id=".$r." AND players_max < " . intval($_GET["pall"]));
    $db->query("INSERT INTO ConnectionRounds (connection_id, round_id, points)
                VALUES  (".$con.", ".$r.", 0)");
}
function PLAYER_LEFT($db){
    $db->query("UPDATE Connections SET connection_end = NOW(), players_end = ".intval($_GET["pall"]).", ping = ".intval($_GET["ping"])." WHERE player_name='".$db->escape_string($_GET["name"])."' ORDER BY id DESC LIMIT 1");
    $conn = curr_conn($db, $_GET["name"]);
    $r = curr_round($db);
    $db->query("UPDATE ConnectionRounds SET points = ".intval($_GET["points"])." WHERE connection_id = $conn AND round_id = $r ORDER BY id DESC LIMIT 1");
}

function PLAYER_KILLED($db){
    $rid = curr_round($db);
    $db->query('INSERT INTO Kills (round_id, `time`, player_name, player_ping,
        damager_name, damager_ping, weapon, distance, isRoadKill, isHeadShot)
    VALUES
    ('.$rid.', NOW(), "'.$db->escape_string($_GET["name"]).'", "'.intval($_GET["ping"]).'",
    "'.$db->escape_string($_GET["killer"]).'","'.intval($_GET["killerping"]).'",
    "'.$db->escape_string($_GET["weapon"]).'", "'.$db->escape_string($_GET["distance"]).'",
    "'.$db->escape_string($_GET["roadkill"]).'","'.$db->escape_string($_GET["headshot"]).'" )');
}
function PLAYER_SUPPRESSED($db){
    $rid = curr_round($db);
    $db->query('INSERT INTO `Supressions` (round_id, `time`, player_name, player_ping,
        enemy_name, enemy_ping)
    VALUES
    ('.$rid.', NOW(), "'.$db->escape_string($_GET["name"]).'", "'.intval($_GET["ping"]).'",
    "'.$db->escape_string($_GET["enemy_ping"]).'","'.intval($_GET["enemyping"]).'")');

}
function WEAPON_CHANGED($db){
    $rid = curr_round($db);
    $db->query('INSERT INTO `WeaponChanges` (`time`, player_name, round_id) VALUES (NOW(), "'.$db->escape_string($_GET["name"]).'", '.$rid.')');
    var_dump($db);
}
function PLAYER_ENTERED_POINT($db){
    $rid = curr_round($db);
    $db->query('INSERT INTO `Captures` (`time`, player_name, round_id) VALUES (NOW(), "'.$db->escape_string($_GET["name"]).'", '.$rid.')');
}
function PLAYER_KICKEDFROMSQUAD($db){
    $rid = curr_round($db);
    $db->query('INSERT INTO `SquadKicks` (`time`, player_name, round_id) VALUES (NOW(), "'.$db->escape_string($_GET["name"]).'", '.$rid.')');
}
function PLAYER_REVIVED($db){
    $rid = curr_round($db);
    $db->query('INSERT INTO `Revives` (`time`, player_name, reviver_name, round_id) VALUES (NOW(), "'.$db->escape_string($_GET["name"]).'", "'.$db->escape_string($_GET["revi"]).'", '.$rid.')');
}
function PLAYER_SPAWN_ON($db){
    $rid = curr_round($db);
    $db->query('INSERT INTO `PlayerSpawns` (`time`, player_name, spawn_on_name, round_id) VALUES (NOW(), "'.$db->escape_string($_GET["name"]).'", "'.$db->escape_string($_GET["on"]).'", '.$rid.')');
}
function PLAYER_RESUPPLY($db){
    $rid = curr_round($db);
    $db->query('INSERT INTO `Resuplies` (`time`, player_name, supplier_name, mag_count, round_id) VALUES (NOW(), "'.$db->escape_string($_GET["name"]).'", "'.$db->escape_string($_GET["on"]).'", '.intval($_GET["count"]).' ,'.$rid.')');

}
function WEAPON_RELOAD($db){
    $rid = curr_round($db);
    $db->query('INSERT INTO `PlayerSpawns` (`time`, player_name, weapon, round_id) VALUES (NOW(), "'.$db->escape_string($_GET["name"]).'", "'.$db->escape_string($_GET["weapon"]).'", '.$rid.')');
}

if(function_exists($_GET["event"])){
    $db = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    $_GET["event"]($db);
    $db->close();
}
else
    die("Something went wrong ...");
