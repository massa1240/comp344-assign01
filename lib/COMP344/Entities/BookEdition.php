<?php

namespace COMP344\Entities;

/**
 * @Entity
 * @Table(name="book_edition")
 */
class BookEdition {

	/**
	 * @Id
	 * @Column(type="string")
	 */
	private $isbn;

	/**
	 * @Column(type="string")
	 */
	private $picture;

	/**
	 * @ManyToOne(targetEntity="COMP344\Entities\Publisher",cascade={"persist"})
	 * @JoinColumn(name="publisher_id", referencedColumnName="id")
	 */
	private $publisher;

	/**
	 * @OneToOne(targetEntity="COMP344\Entities\Book")
	 * @JoinColumn(name="book_id", referencedColumnName="id")
	 */
	private $book;

	/**
	 * @Column(type="integer")
	 */
	private $stock;

	/**
	 * @Column(type="integer")
	 */
	private $pages;

	/**
	 * @Column(type="integer")
	 */
	private $edition;

	/**
	 * @Column(type="integer")
	 */
	private $year;

	/**
	 * @Column(type="decimal", precision=2)
	 */
	private $price;

	/**
	 * Gets the value of price.
	 *
	 * @return string
	 */
	public function getPrice() {
		return $this->price;
	}

	/**
	 * Gets the value of title.
	 *
	 * @return string
	 */
	public function getTitle() {
		return $this->book->getTitle();
	}

	/**
	 * Gets the value of picture.
	 *
	 * @return string
	 */
	public function getPicture() {
		return $this->picture;
	}

	/**
	 * Gets the value of isbn.
	 *
	 * @return string
	 */
	public function getIsbn() {
		return $this->isbn;
	}

	/**
	 * Gets the value of stock.
	 *
	 * @return string
	 */
	public function getStock() {
		return $this->stock;
	}

	/**
	 * Gets the value of publisher.
	 *
	 * @return string
	 */
	public function getPublisherName() {
		return $this->publisher->getName();
	}

	/**
	 * Gets the value of pages.
	 *
	 * @return int
	 */
	public function getPages() {
		return $this->pages;
	}

	/**
	 * Gets the value of edition.
	 *
	 * @return int
	 */
	public function getEdition() {
		return $this->edition;
	}

	/**
	 * Gets the value of year.
	 *
	 * @return int
	 */
	public function getYear() {
		return $this->year;
	}
}