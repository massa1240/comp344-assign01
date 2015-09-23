<?php

namespace COMP344\Controller;

class RegisterController extends PageAbstractController {

	protected $view = 'register.twig';

	public function dispatch() {

		if ($this->isPost()) {
			$em       = $this->getEm();
			$email    = $this->getParam('email');
			$customer = $em->getRepository('COMP344\Entities\Customer')->find($email);

			if ($customer->isRegistered()) {
				$this->setFlashMessage('error', 'Your e-mail is already registered. Please login.');
				$this->redirect($this->urlFor('home'));
			} else {
				$code     = $this->getParam('postcode');
				$postcode = $em->getRepository("COMP344\Entities\PostCode")->find($code);

				if (!$postcode) {
					$postcode = new \COMP344\Entities\PostCode($code, $em->getRepository("COMP344\Entities\State")->find($this->getParam('state')));
				}
				$customer->setPassword($this->getParam('password'));
				$customer->setAddress($this->getParam('address'), $postcode);
				$em->persist($customer);
				$em->flush();

				$message = "
					Hello, {$customer->getName()}\n\n
					Thank you for registering in my Web Shop.
					\n
					Your Username is your MQU e-mail and the password is the one you have chosen.
					\n";

				\COMP344\Mail\Sender::sendEmail($email, 'jose-erima.fernandes-junior@students.mq.edu.au', 'Registration confirmation', $message);
				$this->setFlashMessage('success', 'You were successfully registered. You can now login.');
				$this->redirect($this->urlFor('home'));
			}
		}
	}
}