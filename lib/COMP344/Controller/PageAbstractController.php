<?php

namespace COMP344\Controller;

abstract class PageAbstractController extends AbstractController {

	private $vars;

	protected $view;

	public function __construct(\Slim\Slim $app, $args = array()) {
		$this->vars = array();
		parent::__construct($app, $args);
		$app->render($this->view, $this->vars);
	}

	public function assignVar($var, $content) {
		$this->vars[$var] = $content;
	}
}