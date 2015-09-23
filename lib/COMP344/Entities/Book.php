<?php

namespace COMP344\Entities;

/**
 * @Entity
 * @Table(name="book")
 */
class Book {

	/**
	 * @Id
	 * @Column(type="integer")
	 */
	private $id;

	/**
	 * @Column(type="string")
	 */
	private $title;

	/**
	 * @ManyToMany(targetEntity="COMP344\Entities\Author")
	 * @JoinTable(name="book_has_author",
	 *      joinColumns={@JoinColumn(name="book_id", referencedColumnName="id")},
	 *      inverseJoinColumns={@JoinColumn(name="author_id", referencedColumnName="id")}
	 *      )
	 **/
	private $authors;

	public function __construct() {
		$this->authors = new \Doctrine\Common\Collections\ArrayCollection();
	}

	public function getTitle() {
		return $this->title;
	}
}