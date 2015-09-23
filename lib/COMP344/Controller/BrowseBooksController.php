<?php

namespace COMP344\Controller;

class BrowseBooksController extends PageAbstractController {

	protected $view = 'browse-books.twig';

	public function dispatch() {

		$em = $this->getEm();

		$unit = $this->getArg('unit');

		$units = $em->getRepository('COMP344\Entities\Unit')->findAll();
		$this->assignVar('units', $units);

		if (!$unit) {//verify if unit has been passed as parameter and find all books if not
			$this->assignVar('books', $em->getRepository('COMP344\Entities\BookEdition')->findAll());
		} else {//else, retrieve books from unit
			$u = $em->find('COMP344\Entities\Unit', $unit);
			if ($u) {
				$this->assignVar('selected_unit', $u->getCode());
				$this->assignVar('books', $u->getBooks());
			} else {
				$this->notFound();
			}
		}
	}
}