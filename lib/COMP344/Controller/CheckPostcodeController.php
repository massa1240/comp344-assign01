<?php

namespace COMP344\Controller;

class CheckPostcodeController extends AjaxAbstractController {

	public function dispatch() {

		$url = "https://auspost.com.au/api/postcode/search.json?q={$this->getParam('q')}";

		$ch = curl_init();

		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, array('auth-key: be2d0273-9571-4f4c-a143-9bd440639f6a'));
		curl_setopt($ch, CURLOPT_FAILONERROR, FALSE);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

		$json_response = curl_exec($ch);
		//$status = curl_getinfo($send_curl, CURLINFO_HTTP_CODE);
		curl_close($ch);
		$data = json_decode($json_response, true);

		foreach ($data['localities']['locality'] as $key => $data) {
			$this->data[$key]['postcode'] = $data['postcode'];
			$this->data[$key]['state']    = $data['state'];
			$this->data[$key]['suburb']   = $data['location'];
		}
	}
}