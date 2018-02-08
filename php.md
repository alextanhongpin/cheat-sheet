## Install dependencies through composer

```bash
$ composer install
```

## Run migration for laravel

```bash
$ php artisan migrate
```

## Start a local server
```bash
$ php -S localhost:8000
```

## Posting JSON using cURL

```php
<?php

class SomeService {
	public function authorize($url, $data) {

		$defaults = array(
			CURLOPT_URL => $url,
			CURLOPT_POST => 1,
			CURLOPT_POSTFIELDS => json_encode($data),
			CURLOPT_HTTPHEADER => array('Content-Type: application/json'),
			CURLOPT_RETURNTRANSFER => 1
		);

		$ch = curl_init();
		curl_setopt_array($ch, $defaults);

		if (!$result = curl_exec($ch) ) {
			return curl_error($ch);
		}

		if (!curl_errno($ch)) {
			switch ($http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE)) {
				case 200:
				break;
				default:
				return 'Unexpected HTTP code: ' . $http_code . '. Error: ' . $result;
			}
		}
		return json_decode($result);
	}

}
$url = 'http://localhost:3000/';
$auth = new SomeService();

$jsonData = array(
	'election' => 1,
	'name' => 'test'
);

$output = $auth->authorize($url, $jsonData);
// var_dump($output);
// print_r($output);
// echo $output->name;
// die();
```

## Posting Form Data with cURL

```php
<?php

class SomeService {
	public function authorize($url, $data) {

		$defaults = array(
			CURLOPT_URL => $url,
			CURLOPT_POST => 1,
			CURLOPT_POSTFIELDS => http_build_query($data),
			CURLOPT_HTTPHEADER => array('Content-Type: application/x-www-form-urlencoded'),
			CURLOPT_RETURNTRANSFER => 1
		);

		$ch = curl_init();
		curl_setopt_array($ch, $defaults);

		if (!$result = curl_exec($ch) ) {
			return curl_error($ch);
		}

		if (!curl_errno($ch)) {
			switch ($http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE)) {
				case 200:
				break;
				default:
				return 'Unexpected HTTP code: ' . $http_code . '. Error: ' . $result;
			}
		}
		return json_decode($result);
	}
}
$url = 'http://localhost:5000/connect/token';
$auth = new SomeService();

$jsonData = array(
	'grant_type' => 'client_credentials',
	'scope' => 'api',
	'client_id' => 'client',
	'client_secret' => 'secret'
);

$output = $auth->authorize($url, $jsonData);
var_dump($output);
// print_r($output);
// echo $output->name;
// die();
```
