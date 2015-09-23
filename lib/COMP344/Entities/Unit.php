<?php

namespace COMP344\Entities;

/**
 * @Entity
 * @Table(name="unit")
 */
class Unit {

	/**
	 * @Id
	 * @Column(type="string")
	 */
	private $code;

	/**
	 * @Column(type="string")
	 */
	private $name;

	/**
	 * @ManyToMany(targetEntity="COMP344\Entities\BookEdition")
	 * @JoinTable(name="unit_has_book_edition",
	 *      joinColumns={@JoinColumn(name="unit_code", referencedColumnName="code")},
	 *      inverseJoinColumns={@JoinColumn(name="book_edition_isbn", referencedColumnName="isbn")}
	 *      )
	 */
	private $books;

	public function getName() {
		return $this->name;
	}

	public function getCode() {
		return $this->code;
	}

	public function getBooks() {
		return $this->books;
	}

	public function __construct() {
		$this->books = new \Doctrine\Common\Collections\ArrayCollection();
	}

}