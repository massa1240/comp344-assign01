<?php

namespace COMP344\Controller;

class ViewBookController extends PageAbstractController {

	protected $view = 'view-book.twig';

	public function dispatch() {

		$book = $this->getEm()->find('COMP344\Entities\BookEdition', $this->getArg('book'));

		if ($book) {
			$this->assignVar('book', $book);
		} else {
			$this->notFound();
		}
	}
}