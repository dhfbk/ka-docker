<?php

define('RC_ADMIN_FILE', "/var/run/secrets/rocketchat_secret");
define('RC_APP_FILE', "/apps/app.zip");
define('RC_AVATAR_FILE', "/apps/logo_kidactions4_512.png");
define('RC_LOCK_FILE', "/apps/rc.lock");

$numTries = 100;
$sleepTime = 5;

if (file_exists(RC_LOCK_FILE)) {
	print("Script already executed\n");
	exit();
}

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

function call_post_with_pars($url, $data, $headers = []) {
	$result = call_post($url, $data, $headers);
	$result = json_decode($result);
	return $result;
}

function update_setting($variable, $value, $headers = []) {
	$url = "http://rocketchat:3000/chat/api/v1/settings/$variable";
	$data = json_encode(["value" => $value]);
	$result = call_post_with_pars($url, $data, $headers);
	result_log($result, "$variable value updated", "ERR in updating $variable value");
}

function result_log($result, $msg_ok, $msg_err) {
	if (is_string($result)) {
		$result = json_decode($result);
	}
	if ($result->success) {
		print("$msg_ok\n");
	}
	else {
		fwrite(STDERR, "$msg_err\n");
		fwrite(STDERR, print_r($result, true));
		exit();
	}
}

$url = "http://rocketchat:3000/chat/api/v1/login";
$data = json_encode(["username" => "admin", "password" => $rcPassword]);

$result = false;
$loggedIn = false;
$headersJSON = [];
$headers = [];
$num = 0;
while (($result === false || $loggedIn === false) && $num++ < $numTries) {
	print("Trying to login ($num)\n");
	$result = call_post($url, $data, array('Content-Type: application/json'));
	if ($result === false) {
		sleep($sleepTime);
		continue;
	}
	$result = json_decode($result);
	if ($result->status === "success") {
		print("Login successful\n");
		$loggedIn = true;
		$headersJSON = [
			"X-Auth-Token: {$result->data->authToken}",
			"X-User-Id: {$result->data->userId}",
			"Content-Type: application/json",
		];
		$headers = [
			"X-Auth-Token: {$result->data->authToken}",
			"X-User-Id: {$result->data->userId}",
		];
	}
	else {
		fwrite(STDERR, "ERR in login\n");
		fwrite(STDERR, print_r($result, true));
		sleep($sleepTime);
	}
}

$url = "http://rocketchat:3000/chat/api/v1/users.info?username=admin";
$result = call_get($url, $headersJSON);
result_log($result, "User info loaded", "ERR in loading user info");

$user = json_decode($result, true);

$num = 0;
$result = false;
while (($result === false || !$result->success) && $num++ < $numTries) {
	print("Trying to update user info ($num)\n");
	$url = "http://rocketchat:3000/chat/api/v1/users.update";
	$data = json_encode([
		"userId" => $user['user']['_id'],
		"data" => [
			"name" => "Kid Actions Admin",
			"email" => "admin@kidactions.eu"
		]
	]);
	$result = call_post_with_pars($url, $data, $headersJSON);
	if (!$result->success) {
		fwrite(STDERR, "ERR in updating user info\n");
		fwrite(STDERR, print_r($result, true));
		sleep(1);
	}
}


// $url = "http://rocketchat:3000/chat/api/v1/users.update";
// $data = json_encode([
// 	"userId" => $user['user']['_id'],
// 	"data" => [
// 		"name" => "Kid Actions Admin",
// 		"email" => "admin@kidactions.eu"
// 	]
// ]);
// $result = call_post_with_pars($url, $data, $headersJSON);
result_log($result, "User info updated", "ERR in updating user info");

update_setting("Accounts_TwoFactorAuthentication_By_Email_Enabled", false, $headersJSON);
update_setting("Accounts_TwoFactorAuthentication_By_Email_Auto_Opt_In", false, $headersJSON);
update_setting("Accounts_TwoFactorAuthentication_By_TOTP_Enabled", false, $headersJSON);
update_setting("Accounts_TwoFactorAuthentication_Enabled", false, $headersJSON);
update_setting("API_Enable_Rate_Limiter", false, $headersJSON);
update_setting("Apps_Framework_Development_Mode", true, $headersJSON);

$url = "http://rocketchat:3000/chat/api/v1/users.setAvatar";
$vars = [];
$result = call_post($url, [
	"userId" => $user['user']['_id'],
	"image" => new CURLFile(RC_AVATAR_FILE, "image/png")
], $headers);
$result = json_decode($result);
result_log($result, "Avatar updated", "ERR in updating avatar");

$url = "http://rocketchat:3000/chat/api/v1/method.call/setAsset";
$contents = utf8_encode(file_get_contents(RC_AVATAR_FILE));
$data = [
	"method" => "setAsset",
	"params" => [
		$contents,
		mime_content_type(RC_AVATAR_FILE),
		"logo"
	]
];
$result = call_post($url, json_encode([
	"message" => json_encode($data)
]), $headersJSON);
result_log($result, "Main image updated", "ERR in updating main image");

update_setting("Accounts_AllowUserProfileChange", false, $headersJSON);
update_setting("Accounts_AllowUserAvatarChange", false, $headersJSON);
update_setting("Accounts_AllowRealNameChange", false, $headersJSON);
update_setting("Accounts_AllowUserStatusMessageChange", false, $headersJSON);
update_setting("Accounts_AllowUsernameChange", false, $headersJSON);
update_setting("Accounts_AllowEmailChange", false, $headersJSON);
update_setting("Accounts_AllowPasswordChange", false, $headersJSON);

update_setting("UI_Use_Real_Name", true, $headersJSON);

update_setting("Accounts_RegistrationForm", "Disabled", $headersJSON);
update_setting("Livechat_enabled", false, $headersJSON);

/*
$url = "http://rocketchat:3000/chat/api/v1/channels.delete";
$data = json_encode(["roomId" => "GENERAL"]);
$result = call_post_with_pars($url, $data, $headersJSON);
if ($result->success) {
	print("Channel deleted\n");
}
else {
	fwrite(STDERR, "ERR in deleting channel\n");
	fwrite(STDERR, print_r($result, true));
	exit();
}
*/

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
	// if ($result->error !== "App already exists.") {
	// 	exit();
	// }
}

print("Rocket.Chat app installed successfully\n");
touch(RC_LOCK_FILE);
