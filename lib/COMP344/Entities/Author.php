<?php

namespace COMP344\Entities;

/**
 * @Entity
 * @Table(name="author")
 */
class Author {

	/**
	 * @Id
	 * @Column(type="integer")
	 * @GeneratedValue
	 */
	private $id;

	/**
	 * @Column(type="string")
	 */
	private $name;

}