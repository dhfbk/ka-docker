<?php

define('RC_ADMIN_FILE', "/var/run/secrets/rocketchat_secret");
define('RC_APP_FILE', "/apps/app.zip");

$numTries = 100;
$sleepTime = 5;

$rcPassword = file_get_contents(RC_ADMIN_FILE);
$rcPassword = trim($rcPassword);

function call_post($url, $data, $headers = [], $verbose = false) {
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($ch, CURLOPT_VERBOSE, $verbose);
	$result = curl_exec($ch);
	curl_close($ch);
	return $result;
}

function call_get($url, $headers = []) {
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	$result = curl_exec($ch);
	curl_close($ch);
	return $result;
}

function update_setting($variable, $value, $headers = []) {
	$url = "http://rocketchat:3000/chat/api/v1/settings/$variable";
	$data = json_encode(["value" => $value]);
	$result = call_post($url, $data, $headers);
	$result = json_decode($result);
	if ($result->success) {
		print("$variable value updated\n");
	}
	else {
		fwrite(STDERR, "ERR in updating $variable value\n");
		fwrite(STDERR, print_r($result, true));
		exit();
	}
	return $result;
}

$url = "http://rocketchat:3000/chat/api/v1/login";
$data = json_encode(["username" => "admin", "password" => $rcPassword]);

$result = false;
$num = 0;
while ($result === false && $num++ < $numTries) {
	print("Trying to login ($num)\n");
	$result = call_post($url, $data, array('Content-Type: application/json'));
	if ($result === false) {
		sleep($sleepTime);
	}
}
if ($result === false) {
	fwrite(STDERR, "ERR unable to perform login\n");
	exit();
}
$result = json_decode($result);

if ($result->status === "success") {
	print("Login successful\n");
}
else {
	fwrite(STDERR, "ERR in login\n");
	fwrite(STDERR, print_r($result, true));
	exit();
}

$headersJSON = [
	"X-Auth-Token: {$result->data->authToken}",
	"X-User-Id: {$result->data->userId}",
	"Content-Type: application/json",
];
$headers = [
	"X-Auth-Token: {$result->data->authToken}",
	"X-User-Id: {$result->data->userId}",
];

update_setting("Accounts_TwoFactorAuthentication_Enabled", false, $headersJSON);
update_setting("API_Enable_Rate_Limiter", false, $headersJSON);
update_setting("Apps_Framework_Development_Mode", true, $headersJSON);

$url = "http://rocketchat:3000/chat/api/apps";
$result = call_post($url, ["app" => new CURLFile(RC_APP_FILE)], $headers);
$result = json_decode($result);
if ($result->success) {
	print("App uploaded\n");
}
else {
	fwrite(STDERR, "ERR in uploading app\n");
	fwrite(STDERR, print_r($result, true));
	exit();
}

print("Rocket.Chat app installed successfully\n");

