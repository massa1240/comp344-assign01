<?php

namespace COMP344\Entities;

/**
 * @Entity
 * @Table(name="customer")
 * @InheritanceType("SINGLE_TABLE")
 * @DiscriminatorColumn(name="type", type="integer")
 * @DiscriminatorMap({1 = "COMP344\Entities\MQStaff", 2 = "COMP344\Entities\MQStudent"})
 */
abstract class Customer {

	/**
	 * @Column(type="string")
	 */
	private $name;

	/**
	 * @Column(type="string")
	 */
	private $surname;

	/**
	 * @Id
	 * @Column(type="string")
	 */
	private $email;

	/**
	 * @Column(type="string")
	 */
	private $password;

	/**
	 * @ManyToMany(targetEntity="COMP344\Entities\Order")
	 * @JoinTable(name="customer_has_order",
	 *      joinColumns={@JoinColumn(name="customer_email", referencedColumnName="email")},
	 *      inverseJoinColumns={@JoinColumn(name="order_id", referencedColumnName="id", unique=true)}
	 *      )
	 */
	private $orders;

	/**
	 * @OneToOne(targetEntity="COMP344\Entities\Address", mappedBy="customer", cascade={"persist"})
	 **/
	private $address;

	private static $crypt;

	const MIN_COST = 14;

	public static function encryptPassword($password) {

		return self::getCrypt()->create($password);
	}

	public function verifyPassword($password) {

		return self::getCrypt()->verify($password, $this->password);

	}

	public function __construct() {
		$this->orders   = new \Doctrine\Common\Collections\ArrayCollection();
		$this->cartItem = new \Doctrine\Common\Collections\ArrayCollection();
	}

	public abstract function getOneID();

	public function setPassword($password) {
		$this->password = self::encryptPassword($password);
	}

	public function getEmail() {
		return $this->email;
	}

	public function isRegistered() {
		return $this->password != null;
	}

	public function getName() {
		return $this->name;
	}

	public function setAddress($address, PostCode $postcode) {
		if ($this->address == null) {
			$this->address = new Address($this);
		}

		$this->address->setAddress($address);
		$this->address->setPostcode($postcode);
	}

	public static function getCrypt() {

		if (self::$crypt == null) {
			self::$crypt = new \Zend\Crypt\Password\Bcrypt(array('cost' => self::MIN_COST));
		}

		return self::$crypt;
	}

	/**
	 * Gets the value of surname.
	 *
	 * @return string
	 */
	public function getSurname() {
		return $this->surname;
	}

	public function getFullName() {
		return "{$this->name} {$this->surname}";
	}
}