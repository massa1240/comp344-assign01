<?php

namespace COMP344\Controller;

class LoginController extends AbstractController {

	public function dispatch() {

		$em       = $this->getEm();
		$username = $this->getParam('email');
		$password = $this->getParam('password');

		$rsm = new \Doctrine\ORM\Query\ResultSetMapping();
		$q   = $em->getRepository('COMP344\Entities\Customer')->find($username);

		if ($q && $q->verifyPassword($password)) {

			$_SESSION['email'] = $username;
			$this->redirect($this->urlFor('browse-books'));

		} else {
			$this->setFlashMessage('error', 'Username or password not valid.');
			$this->redirect($this->urlFor('home'));
		}

	}
}