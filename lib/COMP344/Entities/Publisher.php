<?php

namespace COMP344\Entities;

/**
 * @Entity
 * @Table(name="publisher")
 */
class Publisher {

	/**
	 * @Id
	 * @Column(type="integer")
	 */
	private $id;

	/**
	 * @Column(type="string")
	 */
	private $name;

	/**
	 * Gets the value of name.
	 *
	 * @return mixed
	 */
	public function getName() {
		return $this->name;
	}
}