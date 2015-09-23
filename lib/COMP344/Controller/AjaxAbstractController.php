<?php

namespace COMP344\Controller;

abstract class AjaxAbstractController extends AbstractController {

	protected $data;

	public function __construct(\Slim\Slim $app, $args = array()) {
		if ($app->request->isAjax()) {
			$this->data = array();
			parent::__construct($app, $args);
			$this->dispatch();

			$response                 = $app->response();
			$response['Content-Type'] = 'application/json';
			$response->body(json_encode($this->data));

		} else {
			$this->notFound();
		}
	}
}