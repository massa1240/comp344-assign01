<?php

namespace COMP344\Controller;

class IndexController extends PageAbstractController {

	protected $view = 'index.twig';

	public function dispatch() {

		LogoutController::logout();

	}
}