<?php

namespace COMP344\Controller;

class CheckEmailController extends AjaxAbstractController {

	public function dispatch() {

		$result = $this->getEm()->getRepository('COMP344\Entities\Customer')->find($this->getParam('email'));

		$this->data['name']       = "";
		$this->data['registered'] = false;

		if ($result) {

			if (!$result->isRegistered()) {
				$this->data['name']  = $result->getFullName();
				$this->data['oneid'] = $result->getOneId();
				$this->data['type']  = $result instanceof \COMP344\Entities\MQStaff ? 2 : 1;
			} else {
				$this->data['registered'] = true;
			}
		}
	}
}