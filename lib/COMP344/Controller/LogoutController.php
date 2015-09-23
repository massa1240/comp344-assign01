<?php

namespace COMP344\Controller;

class LogoutController extends AbstractController {

	public static function logout() {

		if (isset($_SESSION['email'])) {
			unset($_SESSION['email']);
		}
	}

	public function dispatch() {
		self::logout();

		$this->redirect($this->urlFor('home'));

	}
}