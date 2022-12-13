<?php

define('MYSQL_PASSWORD_FILE', "/var/run/secrets/mysql_secret");
define('ADMIN_FILE', "/var/run/secrets/admin_secret");
// define('RC_APP_FILE', "/apps/app.zip");
// define('RC_AVATAR_FILE', "/apps/logo_kidactions4_512.png");
define('MYSQL_LOCK_FILE', "/apps/mysql.lock");
define('MYSQL_DUMP', "/apps/kaum.sql");
define('CREENDER_FOLDER', "/var/www/tasks/creender_images");

$numTries = 100;
$sleepTime = 5;

if (file_exists(MYSQL_LOCK_FILE)) {
    print("Script already executed\n");
    exit();
}

$rootPassword = file_get_contents(MYSQL_PASSWORD_FILE);
$rootPassword = trim($rootPassword);

$adminPassword = file_get_contents(MYSQL_PASSWORD_FILE);
$adminPassword = trim($adminPassword);
$adminPassword = md5($adminPassword);

$num = 0;
while ($num++ < $numTries) {
    print("Trying to connect to DB ($num)\n");
    $mysqli = @new mysqli("mysql", "root", $rootPassword, "mysql");
    if ($mysqli->connect_errno) {
        fwrite(STDERR, "Error in DB connection: " . $mysqli->connect_error . "\n");
        sleep($sleepTime);
    }
    else {
        break;
    }
}

$mysqli->query("CREATE DATABASE IF NOT EXISTS `kaum`");
$mysqli->select_db("kaum");

$sql = file_get_contents(MYSQL_DUMP);
$mysqli->multi_query($sql);

while ($mysqli->more_results()) {
    $mysqli->next_result();
    $mysqli->use_result();
}

$num = 0;
while ($num++ < $numTries) {
    print("Trying to setup DB ($num)\n");
    $result = $mysqli->query("INSERT INTO `options` (`id`, `value`, `api`) VALUES ('admin_password', '{$adminPassword}', 0)");
    if (!$result) {
        fwrite(STDERR, "Error: ". $mysqli->error . "\n");
        sleep($sleepTime);
    }
    else {
        break;
    }
}

mkdir(CREENDER_FOLDER);
chown(CREENDER_FOLDER, "www-data");

print("KAUM app installed successfully\n");
touch(MYSQL_LOCK_FILE);
