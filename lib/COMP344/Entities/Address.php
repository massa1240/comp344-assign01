<?php

namespace COMP344\Entities;

/**
 * @Entity
 * @Table(name="address")
 */
class Address {

	/**
	 * @Id
	 * @OneToOne(targetEntity="COMP344\Entities\Customer", inversedBy="address")
	 * @JoinColumn(name="customer_email", referencedColumnName="email")
	 **/
	private $customer;

	/**
	 * @Column(type="string")
	 **/
	private $address;

	/**
	 * @ManyToOne(targetEntity="COMP344\Entities\PostCode",cascade={"persist"})
	 * @JoinColumn(name="postcode", referencedColumnName="postcode")
	 **/
	private $postcode;

	public function __construct(\COMP344\Entities\Customer $customer) {
		$this->customer = $customer;
	}

	public function setAddress($address) {
		$this->address = $address;
	}

	public function setPostcode(PostCode $postcode) {
		$this->postcode = $postcode;
	}
}