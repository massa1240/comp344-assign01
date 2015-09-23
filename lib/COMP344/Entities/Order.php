<?php

namespace COMP344\Entities;

/**
 * @Entity
 * @Table(name="order_head")
 */
class Order {

	/**
	 * @Id
	 * @Column(type="integer")
	 */
	private $id;

	/**
	 * @Column(type="datetime", name="created_date")
	 */
	private $date;

	public function __construct() {
		$this->date = new \Date('now');
	}
}