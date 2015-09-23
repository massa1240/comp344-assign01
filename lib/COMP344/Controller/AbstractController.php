<?php

namespace COMP344\Controller;

abstract class AbstractController {

	private $args;

	/**
	 * @var \Slim\Slim
	 */
	private $app;

	public function __construct(\Slim\Slim $app, $args = array()) {
		$this->app  = $app;
		$this->args = $args;
		$this->dispatch();
	}

	protected function getSlimApp() {
		return $this->app;
	}

	protected function setFlashMessage($var, $msg) {
		$this->app->flash($var, $msg);
		$this->app->flashKeep();
	}

	protected function redirect($page) {
		$this->app->redirect($page);
	}

	protected function urlFor($name, $args = array()) {
		return $this->app->urlFor($name, $args);
	}

	protected function notFound() {
		$this->app->notFound();
	}

	/**
	 * @return \Doctrine\EntityManager
	 */
	protected function getEm() {
		return $this->app->em;
	}

	protected function getArg($arg) {
		return array_key_exists($arg, $this->args) ? $this->args[$arg] : null;
	}

	protected function getParam($param) {
		return $this->app->request->params($param);
	}

	protected function isPost() {
		return $this->app->request->isPost();
	}

	public abstract function dispatch();
}